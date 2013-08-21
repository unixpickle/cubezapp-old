//
//  ANPuzzleGetter.m
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleGetter.h"

@interface ANPuzzleGetter (Private)

- (void)handleList:(NSDictionary *)dict;
- (void)processAPIPuzzles:(NSArray *)puzzles;

@end

@implementation ANPuzzleGetter

- (id)initWithDataManager:(ANDataManager *)aManager delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aManager delegate:aDel])) {
        ANAPICall * list = [[ANAPICall alloc] initWithAPI:@"puzzles.list" params:@{}];
        [self sendAPICall:list returnSelector:@selector(handleList:)];
    }
    return self;
}

#pragma mark - Processing -

- (void)handleList:(NSDictionary *)dict {
    NSMutableArray * puzzles = [NSMutableArray array];
    for (NSDictionary * aPuzzle in [dict objectForKey:@"puzzles"]) {
        ANAPIPuzzle * puzzle = [[ANAPIPuzzle alloc] initWithDictionary:aPuzzle];
        [puzzles addObject:puzzle];
    }
    [self processAPIPuzzles:puzzles];
}

- (void)processAPIPuzzles:(NSArray *)puzzles {
    // add and update local puzzles based on remote
    for (ANAPIPuzzle * puzzle in puzzles) {
        ANPuzzle * localPuzzle = [manager findPuzzleForId:puzzle.identifier];
        if (!localPuzzle) {
            // add the remote puzzle to our puzzle collection
            localPuzzle = [manager createPuzzleObject];
            [localPuzzle decodePuzzle:puzzle.dictionary
                               withId:YES];
            [manager.activeAccount addPuzzlesObject:localPuzzle];
            [delegate puzzleSyncer:self addedPuzzle:localPuzzle];
        } else {
            // update all of our local settings with the remote puzzle
            NSDictionary * dict = [localPuzzle encodePuzzle];
            if (![dict isEqualToDictionary:puzzle.dictionary]) {
                [localPuzzle decodePuzzle:puzzle.dictionary withId:NO];
                [delegate puzzleSyncer:self updatedPuzzle:localPuzzle];
            }
        }
    }
    
    // delete local puzzles based on remote
    for (ANPuzzle * puzzle in manager.activeAccount.puzzles) {
        BOOL exists = NO;
        for (ANAPIPuzzle * aPuzzle in puzzles) {
            if ([aPuzzle.identifier isEqualToData:puzzle.identifier]) {
                exists = YES;
                break;
            }
        }
        if (!exists) {
            [delegate puzzleSyncer:self deletedPuzzle:puzzle];
            [manager.context deleteObject:puzzle];
        }
    }
}

@end
