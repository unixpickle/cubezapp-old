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

- (void)beginSessionSyncers;
- (void)runNextSessionSyncer;

@end

@implementation ANSyncSession

- (void)startSync {
    [self beginPuzzleSyncers];
}

- (void)cancelSync {
    [activeSyncer cancel];
    activeSyncer = nil;
}

#pragma mark - Private -

- (void)handleError:(NSError *)error {
    [self.delegate syncSession:self failedWithError:error];
    [self cancelSync];
}

- (void)beginPuzzleSyncers {
    puzzleSyncers = [@[[ANPuzzleDeleter class], [ANPuzzleAdder class],
                       [ANPuzzleRenamer class], [ANPuzzleSetter class],
                       [ANPuzzleGetter class], [ANPuzzleOrderer class]] mutableCopy];
    [self runNextPuzzleSyncer];
}

- (void)runNextPuzzleSyncer {
    if ([puzzleSyncers count] > 0) {
        Class syncerClass = [puzzleSyncers objectAtIndex:0];
        [puzzleSyncers removeObjectAtIndex:0];
        activeSyncer = [[syncerClass alloc] initWithDataManager:[ANDataManager sharedDataManager]
                                                       delegate:self];
    } else {
        activeSyncer = nil;
        [self beginSessionSyncers];
    }
}

- (void)beginSessionSyncers {
    sessionSyncers = [@[[ANSessionDeleter class], [ANSessionAdder class],
                        [ANSessionGetter class]] mutableCopy];
    [self runNextSessionSyncer];
}

- (void)runNextSessionSyncer {
    if ([sessionSyncers count] > 0) {
        Class syncerClass = [sessionSyncers objectAtIndex:0];
        [sessionSyncers removeObjectAtIndex:0];
        activeSyncer = [[syncerClass alloc] initWithDataManager:[ANDataManager sharedDataManager]
                                                       delegate:self];
    } else {
        [self.delegate syncSessionCompleted:self];
    }
}

#pragma mark - Syncer Delegate -

- (void)generalSyncerCompleted:(id)syncer {
    if ([syncer isKindOfClass:[ANPuzzleSyncer class]]) {
        [self runNextPuzzleSyncer];
    } else if ([syncer isKindOfClass:[ANSessionSyncer class]]) {
        [self runNextSessionSyncer];
    }
}

- (void)generalSyncer:(id)syncer failedWithError:(NSError *)error {
    [self handleError:error];
}

#pragma mark Puzzle Syncer

- (void)puzzleSyncer:(id)syncer updatedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self updatedPuzzle:puzzle];
}

- (void)puzzleSyncer:(id)syncer addedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self addedPuzzle:puzzle];
}

- (void)puzzleSyncer:(id)syncer deletedPuzzle:(ANPuzzle *)puzzle {
    [self.delegate syncSession:self deletedPuzzle:puzzle];
}

#pragma mark Session Syncer

- (void)sessionSyncer:(ANSessionSyncer *)syncer addedSession:(ANSession *)session {
    [self.delegate syncSession:self puzzleGraphChanged:session.puzzle];
}

- (void)sessionSyncer:(ANSessionSyncer *)syncer deletedSession:(ANSession *)session {
    [self.delegate syncSession:self puzzleGraphChanged:session.puzzle];
}

@end
