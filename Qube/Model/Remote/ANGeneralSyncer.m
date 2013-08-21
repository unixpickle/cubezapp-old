//
//  ANGeneralSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGeneralSyncer.h"

@implementation ANGeneralSyncer

@synthesize generalDelegate;

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANGeneralSyncerDelegate>)aDel {
    if ((self = [super init])) {
        manager = aMan;
        generalDelegate = aDel;
        
        apiCalls = [NSMutableArray array];
    }
    return self;
}

- (void)sendAPICall:(ANAPICall *)call returnSelector:(SEL)selector {
    [apiCalls addObject:call];
    __weak ANAPICall * weakCall = call;
    [call fetchResponse:^(NSError * error, NSDictionary * obj) {
        [apiCalls removeObject:weakCall];
        if (error) {
            [self.generalDelegate generalSyncer:self failedWithError:error];
            [self cancel];
        } else if (selector) {
            void * objVoid = (__bridge void *)obj;
            NSMethodSignature * signature = [self methodSignatureForSelector:selector];
            NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setSelector:selector];
            [invocation setTarget:self];
            [invocation setArgument:&objVoid atIndex:2];
            [invocation invoke];
            if ([self isCompleted]) {
                [self.generalDelegate generalSyncerCompleted:self];
            }
        }
    }];
}

- (void)cancel {
    for (ANAPICall * call in apiCalls) {
        [call cancel];
    }
    apiCalls = nil;
}

// overridden in the ANPuzzleSyncer class
- (BOOL)isCompleted {
    return [apiCalls count] == 0;
}

@end
