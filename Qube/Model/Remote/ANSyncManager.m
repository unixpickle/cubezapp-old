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
    for (id<ANSyncSessionDelegate> delegate in delegates) {
        [anInvocation invokeWithTarget:delegate];
    }
}

+ (ANSyncManager *)sharedSyncManager {
    static ANSyncManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANSyncManager alloc] init];
    });
    return manager;
}

- (id)init {
    if ((self = [super init])) {
        delegates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addDelegate:(id<ANSyncManagerDelegate>)delegate {
    [delegates addObject:delegate];
}

- (void)removeDelegate:(id<ANSyncManagerDelegate>)delegate {
    [delegates removeObject:delegate];
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
    
    for (id<ANSyncManagerDelegate> delegate in delegates) {
        [delegate syncManagerStarted:self];
    }
}

- (void)cancelSync {
    for (id<ANSyncManagerDelegate> delegate in delegates) {
        [delegate syncManagerCancelled:self];
    }
    [session cancelSync];
    session = nil;
}

#pragma mark Delegate

- (void)syncSession:(ANSyncSession *)aSession failedWithError:(NSError *)error {
    [self cancelSync];
    for (id<ANSyncSessionDelegate> delegate in delegates) {
        [delegate syncSession:aSession failedWithError:error];
    }
}

- (void)syncSessionCompleted:(ANSyncSession *)aSession {
    [self cancelSync];
    for (id<ANSyncSessionDelegate> delegate in delegates) {
        [delegate syncSessionCompleted:aSession];
    }
}

@end
