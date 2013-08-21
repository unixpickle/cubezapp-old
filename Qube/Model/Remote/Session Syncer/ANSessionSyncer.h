//
//  ANSessionSyncer.h
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGeneralSyncer.h"
#import "ANDataManager.h"

@class ANSessionSyncer;

@protocol ANSessionSyncerDelegate <ANGeneralSyncerDelegate>

- (void)sessionSyncer:(ANSessionSyncer *)syncer deletedSession:(ANSession *)session;
- (void)sessionSyncer:(ANSessionSyncer *)syncer addedSession:(ANSession *)session;

@end

@interface ANSessionSyncer : ANGeneralSyncer {
    __weak id<ANSessionSyncerDelegate> delegate;
}

@property (nonatomic, weak) id<ANSessionSyncerDelegate> delegate;

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANSessionSyncerDelegate>)aDel;

@end
