//
//  ANGridView.m
//  GridView
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGridView.h"

@interface ANGridView (Private)

- (void)iterateCellFrames:(void (^)(NSInteger index, CGRect frame))block;
- (void)iterateCellFrames:(void (^)(NSInteger index, CGRect frame))block count:(NSInteger)count;
- (void)layoutItems;
- (ANGridViewCell *)cellForItem:(ANGridViewItem *)item;
- (NSInteger)closestIndexForCell:(ANGridViewCell *)cell;

@end

@implementation ANGridView

@synthesize itemsPerRow, itemPadding;

- (NSArray *)items {
    NSMutableArray * items = [NSMutableArray array];
    for (ANGridViewCell * cell in cells) {
        [items addObject:cell.item];
    }
    return items;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[ANAutoscrollView alloc] initWithFrame:self.bounds];
        scrollView.canCancelContentTouches = NO;
        self.itemsPerRow = 2;
        self.itemPadding = 15;
        cells = [[NSMutableArray alloc] init];
        [self addSubview:scrollView];
        scrollView.multipleTouchEnabled = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)theItems {
    if ((self = [self initWithFrame:frame])) {
        cells = [NSMutableArray array];
        for (ANGridViewItem * item in theItems) {
            ANGridViewCell * cell = [[ANGridViewCell alloc] initWithFrame:item.bounds item:item];
            [item setDelegate:self];
            [cell setDelegate:self];
            [cells addObject:cell];
        }
        [self layoutItems];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    scrollView.frame = self.bounds;
}

#pragma mark - Editing -

- (void)startEditing {
    if (isEditing) return;
    isEditing = YES;
    [UIView animateWithDuration:0.3 animations:^{
        for (ANGridViewCell * cell in cells) {
            [cell setEditing:YES];
        }
    }];
    [self.delegate gridViewDidBeginEditing:self];
}

- (void)stopEditing {
    if (!isEditing) return;
    isEditing = NO;
    [UIView animateWithDuration:0.3 animations:^{
        for (ANGridViewCell * cell in cells) {
            [cell setEditing:NO];
        }
    }];
    [self.delegate gridViewDidEndEditing:self];
}

- (void)deleteItem:(ANGridViewItem *)item animated:(BOOL)flag completed:(void (^)())block {
    ANGridViewCell * cell = [self cellForItem:item];
    if (flag) {
        [UIView animateWithDuration:0.3 animations:^{
            NSLog(@"foo");
            cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
            cell.alpha = 0;
            [cells removeObject:cell];
            [self layoutItems];
        } completion:^(BOOL finished) {
            [cell removeFromSuperview];
            if (block) block();
        }];
    } else {
        [cell removeFromSuperview];
        [cells removeObject:cell];
        [self layoutItems];
    }
}

- (void)addItem:(ANGridViewItem *)item animated:(BOOL)flag completed:(void (^)())block {
    [item setDelegate:self];
    ANGridViewCell * cell = [[ANGridViewCell alloc] initWithFrame:item.bounds item:item];
    [cell setDelegate:self];
    [cells addObject:cell];
    [cell setEditing:isEditing];
    if (flag) {
        cell.alpha = 0;
        [self layoutItems];
        [UIView animateWithDuration:0.3 animations:^{
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            if (block) block();
        }];
    } else {
        [self layoutItems];
    }
}

- (void)moveItem:(ANGridViewItem *)item toIndex:(NSInteger)index {
    ANGridViewCell * cell = [self cellForItem:item];
    NSInteger currentIndex = [cells indexOfObject:cell];
    if (currentIndex < index) {
        // we are moving the cell up, meaning we should move back
        // all the other items in the list
        for (int i = currentIndex; i < index; i++) {
            cells[i] = cells[i + 1];
        }
    } else if (currentIndex > index) {
        // moving the cell back, we should move up all items
        for (int i = currentIndex; i > index; i--) {
            cells[i] = cells[i - 1];
        }
    }
    cells[index] = cell;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutItems];
    }];
    [self.delegate gridViewDidReorder:self];
}

#pragma mark - Layout -

- (void)layoutItems {
    __block CGFloat height = 0;
    [self iterateCellFrames:^(NSInteger index, CGRect frame) {
        ANGridViewCell * cell = cells[index];
        if (!cell.isDragging) cell.frame = frame;
        if (![cell superview]) {
            [scrollView addSubview:cell];
            [scrollView sendSubviewToBack:cell];
        }
        height = CGRectGetMaxY(frame);
    }];
    
    scrollView.contentSize = CGSizeMake(self.frame.size.width, MAX(height + 10, scrollView.frame.size.height));
}

- (void)iterateCellFrames:(void (^)(NSInteger index, CGRect frame))block {
    [self iterateCellFrames:block count:cells.count];
}

- (void)iterateCellFrames:(void (^)(NSInteger index, CGRect frame))block count:(NSInteger)count {
    CGFloat itemSize = (self.frame.size.width / self.itemsPerRow) - (self.itemPadding * (self.itemsPerRow + 1)) / self.itemsPerRow;
    
    CGPoint itemLocation = CGPointMake(self.itemPadding, self.itemPadding);
    CGFloat rowLength = 0;
    for (NSInteger i = 0; i < count; i++) {
        CGRect frame = CGRectMake(itemLocation.x, itemLocation.y, itemSize, itemSize);
        block(i, frame);
        rowLength++;
        if (rowLength == self.itemsPerRow) {
            itemLocation.x = self.itemPadding;
            itemLocation.y += self.itemPadding + itemSize;
            rowLength = 0;
        } else {
            itemLocation.x += self.itemPadding + itemSize;
        }
    }
}

- (NSInteger)closestIndexForCell:(ANGridViewCell *)cell {
    __block NSInteger bestIndex = -1;
    CGFloat area = cell.frame.size.width * cell.frame.size.height;
    NSInteger cellCount = cells.count;
    if (cellCount % itemsPerRow) {
        cellCount += itemsPerRow - (cellCount % itemsPerRow);
    }
    [self iterateCellFrames:^(NSInteger index, CGRect frame) {
        CGRect intersection = CGRectIntersection(frame, cell.frame);
        if (intersection.size.width * intersection.size.height > area * 0.6) {
            bestIndex = index;
        }
    } count:cellCount];
    if (bestIndex >= (NSInteger)cells.count) bestIndex = cells.count - 1;
    return bestIndex;
}

#pragma mark - Cells -

- (void)gridViewItemHeld:(ANGridViewItem *)item {
    ANGridViewCell * cell = [self cellForItem:item];
    [self startEditing];
    [scrollView bringSubviewToFront:cell];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setDragging:YES];
    }];
    [scrollView beginContextForView:cell];
}

- (void)gridViewItem:(ANGridViewItem *)view draggedOffset:(CGPoint)point {
    ANGridViewCell * cell = [self cellForItem:view];
    CGPoint center = cell.center;
    center.x += point.x;
    center.y += point.y;
    cell.center = center;
    
    [scrollView contextUpdate];
    
    NSInteger index = [self closestIndexForCell:cell];
    if (index < 0) return;
    if (cells[index] == cell) return;
    [self moveItem:cell.item toIndex:index];
}

- (void)gridViewItemReleased:(ANGridViewItem *)item {
    ANGridViewCell * cell = [self cellForItem:item];
    [scrollView endContext];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setDragging:NO];
        [self layoutItems];
    }];
}

- (void)gridViewCellDeleted:(ANGridViewCell *)cell {
    [self.delegate gridView:self willDelete:cell.item];
}

#pragma mark Private

- (ANGridViewCell *)cellForItem:(ANGridViewItem *)item {
    for (ANGridViewCell * cell in cells) {
        if (cell.item == item) return cell;
    }
    return nil;
}

@end
