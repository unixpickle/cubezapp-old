//
//  ANSyncManager.m
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSyncManager.h"

@implementation ANSyncManager

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    Protocol * p = @protocol(ANSyncSessionDelegate);
    struct objc_method_description desc = protocol_getMethodDescription(p, [anInvocation selector],
                                                                        YES, YES);
    if (desc.name == nil) {
        [self doesNotRecognizeSelector:[anInvocation selector]];
        return;
    }
    [anInvocation invokeWithTarget:self.delegate];
}

+ (ANSyncManager *)sharedSyncManager {
    static ANSyncManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANSyncManager alloc] init];
    });
    return manager;
}

#pragma mark - Manager -

- (BOOL)isSyncing {
    return (session != nil);
}

- (void)startSyncing {
    [self cancelSync];
    session = [[ANSyncSession alloc] init];
    session.delegate = (id<ANSyncSessionDelegate>)self;
    [session startSync];
    
    [self.delegate syncManagerStarted:self];
}

- (void)cancelSync {
    [self.delegate syncManagerCancelled:self];
    [session cancelSync];
    session = nil;
}

#pragma mark Delegate

- (void)syncSession:(ANSyncSession *)aSession failedWithError:(NSError *)error {
    [session cancelSync];
    session = nil;
    [self.delegate syncSession:aSession failedWithError:error];
}

- (void)syncSessionCompleted:(ANSyncSession *)aSession {
    [session cancelSync];
    session = nil;
    [self.delegate syncSessionCompleted:aSession];
}

@end
