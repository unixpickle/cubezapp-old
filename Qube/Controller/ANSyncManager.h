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
    ANSyncSession * session;
}

@property (nonatomic, weak) id<ANSyncManagerDelegate> delegate;

+ (ANSyncManager *)sharedSyncManager;

- (BOOL)isSyncing;
- (void)startSyncing;
- (void)cancelSync;

@end
