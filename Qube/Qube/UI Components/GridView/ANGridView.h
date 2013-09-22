//
//  ANGridView.h
//  GridView
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridViewCell.h"
#import "ANAutoscrollView.h"

@class ANGridView;

@protocol ANGridViewDelegate

- (void)gridViewDidReorder:(ANGridView *)gridView;
- (void)gridViewDidBeginEditing:(ANGridView *)gridView;
- (void)gridViewDidEndEditing:(ANGridView *)gridView;
- (void)gridView:(ANGridView *)gridView willDelete:(ANGridViewItem *)item;

@end

@interface ANGridView : UIView <ANGridViewItemDelegate, ANGridViewCellDelegate> {
    ANAutoscrollView * scrollView;
    NSMutableArray * cells;
    BOOL isEditing;
}

@property (readwrite) NSInteger itemsPerRow;
@property (readwrite) CGFloat itemPadding;
@property (readonly) NSArray * items;
@property (nonatomic, weak) id<ANGridViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)theItems;

// editing
- (void)startEditing;
- (void)stopEditing;
- (void)deleteItem:(ANGridViewItem *)item animated:(BOOL)flag completed:(void (^)())block;
- (void)addItem:(ANGridViewItem *)item animated:(BOOL)flag completed:(void (^)())block;
- (void)moveItem:(ANGridViewItem *)item toIndex:(NSInteger)index;

@end
