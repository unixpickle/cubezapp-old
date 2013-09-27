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
- (ANGridViewItem *)gridItemForPuzzle:(ANPuzzle *)aPuzzle;
- (void)statButtonPressed:(UIButton *)sender;
- (void)infoButtonPressed:(UIButton *)sender;

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
    ANPuzzleFrontView * front = (ANPuzzleFrontView *)item.frontside;
    NSData * imageData = [[ANImageManager sharedImageManager] imageDataForHash:puzzle.image];
    UIImage * image = [[UIImage alloc] initWithData:imageData];
    front.puzzleLabel.text = puzzle.name;
    front.puzzleImage.image = image;
    front.backgroundColor = [UIColor colorWithHexValueData:puzzle.iconColor];
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
    NSData * imageData = [[ANImageManager sharedImageManager] imageDataForHash:puzzle.image];
    UIImage * image = [[UIImage alloc] initWithData:imageData];
    ANPuzzleFrontView * front = [[ANPuzzleFrontView alloc] init];
    front.puzzleLabel.text = puzzle.name;
    front.puzzleImage.image = image;
    front.backgroundColor = [UIColor colorWithHexValueData:puzzle.iconColor];
    ANPuzzleBackView * back = [[ANPuzzleBackView alloc] init];
    ANGridViewItem * item = [[ANGridViewItem alloc] initWithFrontside:front
                                                             backside:back];
    item.userInfo = puzzle;
    back.puzzle = puzzle;
    
    [back.infoButton addTarget:self action:@selector(infoButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [back.statButton addTarget:self action:@selector(statButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    
    return item;
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

@end
