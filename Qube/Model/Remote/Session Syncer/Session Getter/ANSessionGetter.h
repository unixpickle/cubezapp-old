//
//  ANSessionGetter.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionSyncer.h"
#import "ANSession+Coding.h"
#import "ANSessionsHasher.h"

// requests
#import "ANAPISessionGetDiff.h"
#import "ANAPISessionGetHashes.h"

// responses
#import "ANAPISessionDiffList.h"
#import "ANAPISessionHashes.h"

@interface ANSessionGetter : ANSessionSyncer <ANSessionsHasherDelegate> {
    NSMutableArray * hashers;
}

- (ANSessionsHasher *)findHasherForPrefix:(NSData *)prefix
                                      len:(NSInteger)len;

- (void)launchHasher:(ANSessionsHasher *)hasher;

@end
