//
//  ANSyncManager.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSyncSession.h"

@interface ANSyncSession (Private)

- (void)handleError:(NSError *)error;
- (void)beginPuzzleSyncers;
- (void)runNextPuzzleSyncer;

@end

@implementation ANSyncSession

- (void)startSync {
    // compose immediate delete requests
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    OfflineChanges * changes = account.changes;
    NSMutableArray * deleteIds = [NSMutableArray array];
    for (OCPuzzleDeletion * deletion in changes.puzzleDeletions) {
        [deleteIds addObject:[deletion identifier]];
    }
    apiCall = [[ANAPIDeleteRequest alloc] initWithPuzzleIds:deleteIds];
    [apiCall fetchResponse:^(NSError * error, NSDictionary * obj) {
        apiCall = nil;
        if (error) {
            [self handleError:error];
        } else {
            ANAPIDeleteResponse * response = [[ANAPIDeleteResponse alloc] initWithDictionary:obj];
            for (OCPuzzleDeletion * deletion in response.requests) {
                [[ANDataManager sharedDataManager].context deleteObject:deletion];
            }
            [self beginPuzzleSyncers];
        }
    }];
}

- (void)cancelSync {
    [activePuzzleSyncer cancel];
    [apiCall cancel];
    activePuzzleSyncer = nil;
    apiCall = nil;
}

#pragma mark - Private -

- (void)handleError:(NSError *)error {
    [self.delegate syncSession:self failedWithError:error];
    [self cancelSync];
}

- (void)beginPuzzleSyncers {
    puzzleSyncers = [@[[ANPuzzleAdder class], [ANPuzzleRenamer class],
                       [ANPuzzleSetter class], [ANPuzzleGetter class]] mutableCopy];
    [self runNextPuzzleSyncer];
}

- (void)runNextPuzzleSyncer {
    if ([puzzleSyncers count] > 0) {
        Class syncerClass = [puzzleSyncers objectAtIndex:0];
        [puzzleSyncers removeObjectAtIndex:0];
        activePuzzleSyncer = [[syncerClass alloc] initWithDataManager:[ANDataManager sharedDataManager]
                                                             delegate:self];
    } else {
        // TODO: run session syncers here
    }
}

#pragma mark - Puzzle Syncers -

- (void)generalSyncerCompleted:(id)syncer {
    if ([syncer isKindOfClass:[ANPuzzleSyncer class]]) {
        [self runNextPuzzleSyncer];
    }
}

- (void)generalSyncer:(id)syncer failedWithError:(NSError *)error {
    [self handleError:error];
}

- (void)puzzleSyncer:(id)syncer updatedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self updatedPuzzle:puzzle];
}

- (void)puzzleSyncer:(id)syncer addedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self addedPuzzle:puzzle];
}

- (void)puzzleSyncer:(id)syncer deletedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self deletedPuzzle:puzzle];
}

@end
