//
//  ANGeneralSyncer.h
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager.h"
#import "ANAPICall.h"

@class ANGeneralSyncer;

@protocol ANGeneralSyncerDelegate

- (void)generalSyncer:(ANGeneralSyncer *)syncer failedWithError:(NSError *)error;
- (void)generalSyncerCompleted:(ANGeneralSyncer *)syncer;

@end

@interface ANGeneralSyncer : NSObject {
    NSMutableArray * apiCalls;
    ANDataManager * manager;
    __weak id<ANGeneralSyncerDelegate> generalDelegate;
}

@property (nonatomic, weak) id<ANGeneralSyncerDelegate> generalDelegate;

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANGeneralSyncerDelegate>)aDel;

- (void)sendAPICall:(ANAPICall *)call returnSelector:(SEL)selector;
- (void)cancel;

// overridden in the ANPuzzleSyncer class
- (BOOL)isCompleted;

@end
