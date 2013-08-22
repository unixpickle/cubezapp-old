//
//  ANPuzzleOrderer.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleOrderer.h"

@implementation ANPuzzleOrderer

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aMan delegate:aDel])) {
        NSMutableArray * theIds = [NSMutableArray array];
        for (ANPuzzle * puzzle in aMan.activeAccount.puzzles) {
            [theIds addObject:puzzle.identifier];
        }
        ANAPICall * call = [[ANAPICall alloc] initWithAPI:@"puzzles.myOrder"
                                                   params:@{@"ids": theIds}];
        [self sendAPICall:call returnSelector:nil];
    }
    return self;
}

@end
