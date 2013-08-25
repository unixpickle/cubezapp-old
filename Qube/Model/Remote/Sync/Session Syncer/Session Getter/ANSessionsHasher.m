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
- (void)sortSessionList:(NSMutableArray *)array;
- (void)generateHashes;

- (void)delegateError:(NSString *)message code:(NSInteger)code;
- (void)delegatePassError:(NSError *)error;
- (void)delegateCompleted;

@end

@implementation ANSessionsHasher

@synthesize delegate;
@synthesize hashes;
@synthesize sessionsForPrefix;
@synthesize prefixLen;
@synthesize requiredPrefix;

- (id)initWithPrefixLen:(NSInteger)len {
    if ((self = [super init])) {
        prefixLen = len;
    }
    return self;
}

- (id)initWithPrefixLen:(NSInteger)len prefix:(NSData *)required {
    if ((self = [super init])) {
        prefixLen = len;
        requiredPrefix = required;
    }
    return self;
}

- (void)start {
    hashes = [[NSMutableDictionary alloc] init];
    sessionsForPrefix = [[NSMutableDictionary alloc] init];
    context = [[NSManagedObjectContext alloc] init];
    NSPersistentStoreCoordinator * theCoordinator = [ANDataManager sharedDataManager].context.persistentStoreCoordinator;
    [context setPersistentStoreCoordinator:theCoordinator];
    
    NSManagedObjectID * theId = [ANDataManager sharedDataManager].activeAccount.objectID;
    backgroundThread = [[NSThread alloc] initWithTarget:self selector:@selector(calculateHashes)
                                                 object:theId];
    [backgroundThread start];
}

- (BOOL)isRunning {
    return backgroundThread != nil;
}

- (void)cancel {
    [backgroundThread cancel];
    backgroundThread = nil;
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
        for (ANPuzzle * puzzle in account.puzzles) {
            for (ANSession * session in puzzle.sessions) {
                if ([NSThread currentThread].isCancelled) return;
                NSAssert(session.identifier.length >= requiredPrefix.length, @"Session identifier is too short.");
                
                // make sure the session matches the prefix query
                if (requiredPrefix.length > 0) {
                    NSData * reqPref = [session.identifier subdataWithRange:NSMakeRange(0, requiredPrefix.length)];
                    if (![reqPref isEqualToData:requiredPrefix]) {
                        continue;
                    }
                }
                
                // add the session to the sessionsForPrefix dictionary
                NSInteger prefLen = prefixLen;
                if (prefLen > [session.identifier length]) {
                    prefLen = [session.identifier length];
                }
                NSData * prefix = [session.identifier subdataWithRange:NSMakeRange(0, prefLen)];
                NSMutableArray * list = [sessionsForPrefix objectForKey:prefix];
                if (!list) {
                    list = [NSMutableArray array];
                    [sessionsForPrefix setObject:list forKey:prefix];
                }
                [list addObject:session];
            }
        }
        
        // hash each group individually
        [self generateHashes];
        if ([NSThread currentThread].isCancelled) return;
        
        // tell the delegate we are done
        [self performSelectorOnMainThread:@selector(delegateCompleted)
                               withObject:nil waitUntilDone:NO];
        
    }
}

- (void)sortSessionList:(NSMutableArray *)array {
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        ANSession * s1 = (ANSession *)obj1;
        ANSession * s2 = (ANSession *)obj2;
        NSAssert(s1.identifier.length == s2.identifier.length, @"Unmatching id lengths");
        const char * s1Data = (const char *)s1.identifier.bytes;
        const char * s2Data = (const char *)s2.identifier.bytes;
        for (int i = 0; i < s1.identifier.length; i++) {
            if (s1Data[i] > s2Data[i]) return NSOrderedDescending;
            if (s1Data[i] < s2Data[i]) return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

- (void)generateHashes {
    for (NSData * key in sessionsForPrefix) {
        if ([NSThread currentThread].isCancelled) return;
        NSMutableArray * sessions = [sessionsForPrefix objectForKey:key];
        [self sortSessionList:sessions];
        NSMutableData * toHash = [NSMutableData data];
        for (ANSession * session in sessions) {
            [toHash appendData:session.identifier];
        }
        [hashes setObject:[toHash md5Hash] forKey:key];
    }
}

#pragma mark Delegate

- (void)delegateError:(NSString *)message code:(NSInteger)code {
    NSError * error = [[NSError alloc] initWithDomain:@"ANSessionHasher"
                                                 code:code
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
    if ([NSThread currentThread].isCancelled) return;
    [self performSelectorOnMainThread:@selector(delegatePassError:)
                           withObject:error
                        waitUntilDone:NO];
}

- (void)delegatePassError:(NSError *)error {
    [delegate sessionsHasher:self failedWithError:error];
    backgroundThread = nil;
}

- (void)delegateCompleted {
    [delegate sessionsHasherCompleted:self];
    backgroundThread = nil;
}

@end
