//
//  ANPuzzleOrderer.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleOrderer.h"

@implementation ANPuzzleOrderer

- (id)initWithDelegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        NSMutableArray * theIds = [NSMutableArray array];
        for (ANPuzzle * puzzle in manager.activeAccount.puzzles) {
            [theIds addObject:puzzle.identifier];
        }
        ANAPICall * call = [[ANAPICall alloc] initWithAPI:@"puzzles.myOrder"
                                                   params:@{@"ids": theIds}];
        [self sendAPICall:call returnSelector:nil];
    }
    return self;
}

@end
