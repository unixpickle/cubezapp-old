//
//  ANSyncManager.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAccountSyncer.h"

#import "ANPuzzleDeleter.h"
#import "ANPuzzleAdder.h"
#import "ANPuzzleRenamer.h"
#import "ANPuzzleSetter.h"
#import "ANPuzzleGetter.h"
#import "ANPuzzleOrderer.h"

#import "ANSessionDeleter.h"
#import "ANSessionAdder.h"
#import "ANSessionGetter.h"

#import "ANAPIPuzzleDeleteResponse.h"

@class ANSyncSession;

@protocol ANSyncSessionDelegate <NSObject>

- (void)syncSession:(ANSyncSession *)session addedPuzzle:(ANPuzzle *)puzzle;
- (void)syncSession:(ANSyncSession *)session deletedPuzzle:(ANPuzzle *)puzzle;
- (void)syncSession:(ANSyncSession *)session updatedPuzzle:(ANPuzzle *)puzzle;
- (void)syncSession:(ANSyncSession *)session puzzleGraphChanged:(ANPuzzle *)puzzle;
- (void)syncSession:(ANSyncSession *)session updatedAccount:(LocalAccount *)account;
- (void)syncSession:(ANSyncSession *)session failedWithError:(NSError *)error;
- (void)syncSessionCompleted:(ANSyncSession *)session;

@end

@interface ANSyncSession : NSObject <ANPuzzleSyncerDelegate, ANSessionSyncerDelegate, ANAccountSyncerDelegate> {
    NSMutableArray * puzzleSyncers;
    NSMutableArray * sessionSyncers;
    ANGeneralSyncer * activeSyncer;
}

@property (nonatomic, weak) id<ANSyncSessionDelegate> delegate;

- (void)startSync;
- (void)cancelSync;

@end
