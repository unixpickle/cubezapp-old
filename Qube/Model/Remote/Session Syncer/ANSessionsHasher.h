//
//  ANSessionsHasher.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager.h"

@class ANSessionsHasher;

@protocol ANSessionsHasherDelegate

- (void)sessionsHasherCompleted:(ANSessionsHasher *)hasher;
- (void)sessionsHasher:(ANSessionsHasher *)hasher failedWithError:(NSError *)e;

@end

@interface ANSessionsHasher : NSObject {
    NSThread * backgroundThread;
    NSManagedObjectContext * context;
    __weak id<ANSessionsHasherDelegate> delegate;
    NSInteger prefixLen;
    
    NSMutableDictionary * hashes;
}

@property (weak) id<ANSessionsHasherDelegate> delegate;
@property (readonly) NSMutableDictionary * hashes;

- (id)initWithPrefixLen:(NSInteger)len;

- (void)start;
- (void)cancel;

@end
