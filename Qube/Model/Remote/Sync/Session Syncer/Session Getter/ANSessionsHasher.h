//
//  ANSessionsHasher.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager.h"
#import "NSData+MD5.h"

@class ANSessionsHasher;

@protocol ANSessionsHasherDelegate

- (void)sessionsHasherCompleted:(ANSessionsHasher *)hasher;
- (void)sessionsHasher:(ANSessionsHasher *)hasher failedWithError:(NSError *)e;

@end

@interface ANSessionsHasher : NSObject {
    NSThread * backgroundThread;
    NSManagedObjectContext * context;
    __weak id<ANSessionsHasherDelegate> delegate;
    
    NSInteger prefixLen; // the number of identifier bytes to consider
    NSData * requiredPrefix; // the identifier bytes to look at (may be empty)
    
    NSMutableDictionary * hashes;
    NSMutableDictionary * sessionsForPrefix;
}

@property (weak) id<ANSessionsHasherDelegate> delegate;
@property (readonly) NSInteger prefixLen;
@property (readonly) NSData * requiredPrefix;
@property (readonly) NSDictionary * hashes;
@property (readonly) NSDictionary * sessionsForPrefix;

- (id)initWithPrefixLen:(NSInteger)len;
- (id)initWithPrefixLen:(NSInteger)len prefix:(NSData *)required;

- (void)start;
- (BOOL)isRunning;
- (void)cancel;

@end
