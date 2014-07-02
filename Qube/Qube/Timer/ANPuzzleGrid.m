//
//  ANPuzzleGrid.m
//  Qube
//
//  Created by Alex Nichol on 9/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleGrid.h"

@interface ANPuzzleGrid (Private)

- (NSArray *)generateAllItems;
- (ANGridViewItem *)createGridItemForPuzzle:(ANPuzzle *)puzzle;
- (void)configureGridViewItem:(ANGridViewItem *)item forPuzzle:(ANPuzzle *)puzzle;
- (ANGridViewItem *)gridItemForPuzzle:(ANPuzzle *)aPuzzle;
- (void)statButtonPressed:(UIButton *)sender;
- (void)infoButtonPressed:(UIButton *)sender;
- (void)puzzleButtonPressed:(UIButton *)sender;

@end

@implementation ANPuzzleGrid

- (id)initWithFrame:(CGRect)frame puzzles:(NSArray *)puzzles {
    NSMutableArray * theItems = [NSMutableArray array];
    for (ANPuzzle * puzzle in puzzles) {
        if (puzzle.hidden) continue;
        ANGridViewItem * item = [self createGridItemForPuzzle:puzzle];
        [theItems addObject:item];
    }
    self = [super initWithFrame:frame items:theItems];
    return self;
}

- (BOOL)hasCellForPuzzle:(ANPuzzle *)puzzle {
    return [self gridItemForPuzzle:puzzle] != nil;
}

- (void)externalPuzzleDeleted:(ANPuzzle *)puzzle {
    ANGridViewItem * item = [self gridItemForPuzzle:puzzle];
    NSAssert(item != nil, @"An item should exist.");
    [self deleteItem:item animated:YES completed:nil];
}

- (void)externalPuzzleAdded:(ANPuzzle *)puzzle {
    NSOrderedSet * puzzles = [ANDataManager sharedDataManager].activeAccount.puzzles;
    NSArray * items = self.items;
    
    NSInteger puzzleIndex = [puzzles indexOfObject:puzzle];
    NSInteger insertIndex = 0;
    for (NSInteger i = puzzleIndex - 1; i >= 0; i--) {
        ANPuzzle * aPuzzle = [puzzles objectAtIndex:i];
        ANGridViewItem * anItem = [self gridItemForPuzzle:aPuzzle];
        if (anItem) {
            insertIndex = [items indexOfObject:anItem] + 1;
            break;
        }
    }
    
    ANGridViewItem * item = [self createGridItemForPuzzle:puzzle];
    [self addItem:item atIndex:insertIndex animated:YES completed:nil];
}

- (void)externalPuzzleUpdated:(ANPuzzle *)puzzle {
    ANGridViewItem * item = [self gridItemForPuzzle:puzzle];
    NSAssert(item != nil, @"An item should exist.");
    [self configureGridViewItem:item forPuzzle:puzzle];
}


#pragma mark - Private -

- (NSArray *)generateAllItems {
    NSMutableArray * list = [NSMutableArray array];
    for (ANPuzzle * puzzle in [ANDataManager sharedDataManager].activeAccount.puzzles) {
        if (puzzle.hidden) continue;
        [list addObject:[self createGridItemForPuzzle:puzzle]];
    }
    return list;
}

- (ANGridViewItem *)createGridItemForPuzzle:(ANPuzzle *)puzzle {
    ANPuzzleFrontView * front = [[ANPuzzleFrontView alloc] init];
    ANPuzzleBackView * back = [[ANPuzzleBackView alloc] init];
    ANGridViewItem * item = [[ANGridViewItem alloc] initWithFrontside:front
                                                             backside:back];
    item.userInfo = puzzle;
    back.puzzle = puzzle;
    front.puzzle = puzzle;
    
    [back.infoButton addTarget:self action:@selector(infoButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [back.statButton addTarget:self action:@selector(statButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [front addTarget:self action:@selector(puzzleButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    
    [self configureGridViewItem:item forPuzzle:puzzle];
    
    return item;
}

- (void)configureGridViewItem:(ANGridViewItem *)item forPuzzle:(ANPuzzle *)puzzle {
    ANPuzzleFrontView * front = (id)item.frontside;
    [front updateWithPuzzle:puzzle];
    
    CGFloat red, green, blue;
    [front.backgroundColor getRed:&red green:&green blue:&blue];
    red = MIN(red + 0.2, 1);
    green = MIN(green + 0.2, 1);
    blue = MIN(blue + 0.2, 1);
    
    
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    item.backside.backgroundColor = color;
}

- (ANGridViewItem *)gridItemForPuzzle:(ANPuzzle *)aPuzzle {
    for (ANGridViewItem * item in self.items) {
        if (item.userInfo == aPuzzle) {
            return item;
        }
    }
    return nil;
}

- (void)statButtonPressed:(UIButton *)sender {
    ANPuzzleBackView * backView = (ANPuzzleBackView *)sender.superview;
    [self.puzzlesDelegate puzzleGrid:self showStats:backView.puzzle];
    
    ANGridViewItem * item = [self gridItemForPuzzle:backView.puzzle];
    [item flipToFrontside];
}

- (void)infoButtonPressed:(UIButton *)sender {
    ANPuzzleBackView * backView = (ANPuzzleBackView *)sender.superview;
    [self.puzzlesDelegate puzzleGrid:self showInfo:backView.puzzle];
    
    ANGridViewItem * item = [self gridItemForPuzzle:backView.puzzle];
    [item flipToFrontside];
}

- (void)puzzleButtonPressed:(UIButton *)sender {
    ANPuzzleFrontView * frontview = (ANPuzzleFrontView *)sender;
    [self.puzzlesDelegate puzzleGrid:self startSession:frontview.puzzle];
}

@end
