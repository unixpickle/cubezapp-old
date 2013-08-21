//
//  ANSessionsHasher.m
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionsHasher.h"

@interface ANSessionsHasher (Private)

- (void)calculateHashes:(NSManagedObjectID *)accountId;

- (void)delegateError:(NSString *)message code:(NSInteger)code;
- (void)delegatePassError:(NSError *)error;

@end

@implementation ANSessionsHasher

@synthesize delegate;

- (id)initWithPrefixLen:(NSInteger)len {
    if ((self = [super init])) {
        prefixLen = len;
    }
    return self;
}

- (void)start {
    hashes = [[NSMutableDictionary alloc] init];
    context = [[NSManagedObjectContext alloc] init];
    NSPersistentStoreCoordinator * theCoordinator = [ANDataManager sharedDataManager].context.persistentStoreCoordinator;
    [context setPersistentStoreCoordinator:theCoordinator];
    
    NSManagedObjectID * theId = [ANDataManager sharedDataManager].activeAccount.objectID;
    backgroundThread = [[NSThread alloc] initWithTarget:self selector:@selector(calculateHashes)
                                                 object:theId];
    [backgroundThread start];
}

- (void)cancel {
    [backgroundThread cancel];
}

#pragma mark - Private -

- (void)calculateHashes:(NSManagedObjectID *)accountId {
    @autoreleasepool {
        
        // find the account
        LocalAccount * account = (LocalAccount *)[context existingObjectWithID:accountId error:nil];
        NSAssert([account isKindOfClass:[LocalAccount class]], @"Invalid active account class.");
        if (!account) {
            [self delegateError:@"Active account object disappeared while syncing" code:1];
            return;
        }
        
        // find every single session object for the account
        NSMutableDictionary * sessionsForPrefix = [NSMutableDictionary dictionary];
        for (ANPuzzle * puzzle in account.puzzles) {
            for (ANSession * session in puzzle.sessions) {
                NSInteger prefLen = prefixLen;
                if (prefLen > [session.identifier length]) {
                    prefLen = [session.identifier length];
                }
                
            }
            [sessions addObjectsFromArray:[puzzle.sessions array]];
        }
        
        //
    }
}

#pragma mark Delegate

- (void)delegateError:(NSString *)message code:(NSInteger)code {
    NSError * error = [[NSError alloc] initWithDomain:@"ANSessionHasher"
                                                 code:code
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
    [self performSelectorOnMainThread:@selector(delegatePassError:)
                           withObject:error
                        waitUntilDone:NO];
}

- (void)delegatePassError:(NSError *)error {
    [delegate sessionsHasher:self failedWithError:error];
}

@end
