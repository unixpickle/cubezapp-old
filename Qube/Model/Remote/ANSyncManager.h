//
//  ANSyncManager.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "ANSyncSession.h"

@class ANSyncManager;

@protocol ANSyncManagerDelegate <ANSyncSessionDelegate>

- (void)syncManagerStarted:(ANSyncManager *)manager;
- (void)syncManagerCancelled:(ANSyncManager *)manager;

@end

@interface ANSyncManager : NSObject {
    NSMutableArray * delegates;
    ANSyncSession * session;
}

+ (ANSyncManager *)sharedSyncManager;
- (void)addDelegate:(id<ANSyncManagerDelegate>)delegate;
- (void)removeDelegate:(id<ANSyncManagerDelegate>)delegate;

- (BOOL)isSyncing;
- (void)startSyncing;
- (void)cancelSync;

@end
