//
//  ANPuzzleGrid.h
//  Qube
//
//  Created by Alex Nichol on 9/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGridView.h"
#import "ANDataManager+Search.h"
#import "Color+HexValue.h"
#import "ANImageManager.h"

#import "ANPuzzleFrontView.h"
#import "ANPuzzleBackView.h"

@class ANPuzzleGrid;

@protocol ANPuzzleGridDelegate

- (void)puzzleGrid:(ANPuzzleGrid *)grid showInfo:(ANPuzzle *)aPuzzle;
- (void)puzzleGrid:(ANPuzzleGrid *)grid showStats:(ANPuzzle *)aPuzzle;
- (void)puzzleGrid:(ANPuzzleGrid *)grid startSession:(ANPuzzle *)aPuzzle;

@end

@interface ANPuzzleGrid : ANGridView

@property (nonatomic, weak) id<ANPuzzleGridDelegate> puzzlesDelegate;

- (id)initWithFrame:(CGRect)frame puzzles:(NSArray *)puzzles;

- (BOOL)hasCellForPuzzle:(ANPuzzle *)puzzle;

/**
 * Called when a puzzle is deleted or hidden.
 */
- (void)externalPuzzleDeleted:(ANPuzzle *)puzzle;

/**
 * Called when a puzzle is added or unhidden.
 */
- (void)externalPuzzleAdded:(ANPuzzle *)puzzle;

/**
 * Called when a puzzle changes.
 */
- (void)externalPuzzleUpdated:(ANPuzzle *)puzzle;

@end
