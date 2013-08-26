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
- (void)runNextSyncer;

@end

@implementation ANSyncSession

- (void)startSync {
    syncerClasses = [@[[ANAccountSyncer class], [ANPuzzleDeleter class],
                       [ANPuzzleAdder class], [ANPuzzleRenamer class],
                       [ANPuzzleSetter class], [ANPuzzleGetter class],
                       [ANPuzzleOrderer class], [ANSessionDeleter class],
                       [ANSessionAdder class], [ANSessionGetter class],
                       [ANImageDownloader class], [ANImageUploader class]] mutableCopy];
    [self runNextSyncer];
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

- (void)runNextSyncer {
    if ([syncerClasses count] > 0) {
        Class syncerClass = [syncerClasses objectAtIndex:0];
        [syncerClasses removeObjectAtIndex:0];
        activeSyncer = [[syncerClass alloc] initWithDelegate:self];
    } else {
        activeSyncer = nil;
        [self.delegate syncSessionCompleted:self];
    }
}

#pragma mark - Syncer Delegate -

- (void)generalSyncerCompleted:(id)syncer {
    [self runNextSyncer];
}

- (void)generalSyncer:(id)syncer failedWithError:(NSError *)error {
    [self handleError:error];
}

#pragma mark Image Downloader

- (void)imageDownloader:(ANImageDownloader *)syncer updatedPuzzleImages:(NSArray *)puzzles {
    for (ANPuzzle * puzzle in puzzles) {
        [self.delegate syncSession:self updatedPuzzle:puzzle];
    }
}

#pragma mark Account Syncer

- (void)accountSyncer:(ANAccountSyncer *)syncer updatedAccount:(LocalAccount *)account {
    [self.delegate syncSession:self updatedAccount:account];
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
    [self.delegate syncSession:self addedSession:session];
}

- (void)sessionSyncer:(ANSessionSyncer *)syncer deletedSession:(ANSession *)session {
    [self.delegate syncSession:self deletedSession:session];
}

@end
