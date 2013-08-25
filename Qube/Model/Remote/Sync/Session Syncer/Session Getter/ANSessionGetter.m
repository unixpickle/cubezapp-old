//
//  ANSessionGetter.m
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionGetter.h"

@interface ANSessionGetter (Private)

- (void)handleDiffList:(NSDictionary *)response;
- (void)handleHashList:(NSDictionary *)response;
- (void)handleIntersectionsWithHashList:(ANAPISessionHashes *)hashes
                         andLocalHasher:(ANSessionsHasher *)localHasher;
- (void)requestFurtherDetails:(NSData *)differingPrefix;

@end

@implementation ANSessionGetter

- (id)initWithDelegate:(id<ANSessionSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        hashers = [NSMutableArray array];
        ANSessionsHasher * hasher = [[ANSessionsHasher alloc] initWithPrefixLen:0];
        [self launchHasher:hasher];
    }
    return self;
}

- (BOOL)isCompleted {
    return [super isCompleted] && [hashers count] == 0;
}

- (void)cancel {
    [super cancel];
    for (ANSessionsHasher * hasher in hashers) {
        hasher.delegate = nil;
        [hasher cancel];
    }
    hashers = nil;
}

#pragma mark - Hasher -

- (ANSessionsHasher *)findHasherForPrefix:(NSData *)prefix
                                      len:(NSInteger)len {
    for (ANSessionsHasher * hasher in hashers) {
        if (hasher.prefixLen == len && [hasher.requiredPrefix isEqualToData:prefix]) {
            return hasher;
        }
    }
    return nil;
}

- (void)launchHasher:(ANSessionsHasher *)hasher {
    hasher.delegate = self;
    [hashers addObject:hasher];
    [hasher start];
}

- (void)sessionsHasher:(ANSessionsHasher *)hasher failedWithError:(NSError *)e {
    [self cancel];
    [self.delegate generalSyncer:self failedWithError:e];
}

- (void)sessionsHasherCompleted:(ANSessionsHasher *)hasher {
    // create an API call and make it
    ANAPICall * call = [[ANAPICallSessionGetHashes alloc] initWithIdPrefix:hasher.requiredPrefix
                                                               prefLen:hasher.prefixLen];
    [self sendAPICall:call returnSelector:@selector(handleHashList:)];
}

#pragma mark - Handling Responses -

- (void)handleDiffList:(NSDictionary *)response {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    ANAPISessionDiffList * diff = [[ANAPISessionDiffList alloc] initWithDictionary:response];
    for (ANSession * session in diff.deleteSessions) {
        [self.delegate sessionSyncer:self deletedSession:session];
        [manager.context deleteObject:session];
    }
    for (NSDictionary * sessDict in diff.addSessions) {
        ANSession * collision = [manager findSessionForId:[sessDict objectForKey:@"id"]];
        NSAssert(collision == nil, @"Collision between server and client ID");
        ANPuzzle * puzzle = [manager findPuzzleForId:[sessDict objectForKey:@"puzzleId"]];
        if (!puzzle) {
            NSLog(@"warning: session added for nil puzzle");
            continue;
        }
        ANSession * newSess = [manager createSessionObject];
        [newSess decodeSession:sessDict];
        [puzzle addSessionsObject:newSess];
        [self.delegate sessionSyncer:self addedSession:newSess];
    }
}

- (void)handleHashList:(NSDictionary *)response {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    ANAPISessionHashes * hashes = [[ANAPISessionHashes alloc] initWithDictionary:response];
    ANSessionsHasher * localHasher = [self findHasherForPrefix:hashes.idPrefix
                                                      len:hashes.prefLen];
    
    if (!localHasher) {
        NSError * e = [NSError errorWithDomain:@"ANSessionsHasher"
                                          code:1
                                      userInfo:@{NSLocalizedDescriptionKey: @"Received invalid response from the server."}];
        [self.generalDelegate generalSyncer:self failedWithError:e];
        [self cancel];
        return;
    }
    
    [hashers removeObject:localHasher];
    
    // find all groups that are not on the remote end and
    // delete them from our local store
    for (NSData * prefix in localHasher.sessionsForPrefix) {
        if (![hashes.hashes objectForKey:prefix]) {
            NSArray * sessionList = [localHasher.sessionsForPrefix objectForKey:prefix];
            for (ANSession * session in sessionList) {
                [self.delegate sessionSyncer:self deletedSession:session];
                [manager.context deleteObject:session];
            }
        }
    }
    
    // find all groups of sessions that are on the server but not
    // on the local store and then request them.
    for (NSData * prefix in hashes.hashes) {
        if (![localHasher.sessionsForPrefix objectForKey:prefix]) {
            ANAPICallSessionGetDiff * getDiff = [[ANAPICallSessionGetDiff alloc] initWithIdPrefix:prefix
                                                                                      ids:@[]];
            [self sendAPICall:getDiff returnSelector:@selector(handleDiffList:)];
        }
    }
    
    // find all groups that are on both the client and the server but which differ
    [self handleIntersectionsWithHashList:hashes andLocalHasher:localHasher];
}

- (void)handleIntersectionsWithHashList:(ANAPISessionHashes *)hashes
                         andLocalHasher:(ANSessionsHasher *)localHasher {
    for (NSData * prefix in hashes.hashes) {
        NSData * localHash = [localHasher.hashes objectForKey:prefix];
        if (!localHash) continue;
        NSData * remoteHash = [hashes.hashes objectForKey:prefix];
        if ([remoteHash isEqualToData:localHash]) continue;
        
        NSArray * localSessions = [localHasher.sessionsForPrefix objectForKey:prefix];
        if ([localSessions count] < 256) {
            // if we have fewer than 256 sessions, figure out precisely
            // what sessions need to get changed
            ANAPICallSessionGetDiff * getDiff = [[ANAPICallSessionGetDiff alloc] initWithIdPrefix:prefix
                                                                                 sessions:localSessions];
            [self sendAPICall:getDiff returnSelector:@selector(handleDiffList:)];
        } else {
            [self requestFurtherDetails:prefix];
        }
    }
}

- (void)requestFurtherDetails:(NSData *)differingPrefix {
    ANSessionsHasher * hasher = [[ANSessionsHasher alloc] initWithPrefixLen:(differingPrefix.length + 1)
                                                                     prefix:differingPrefix];
    [self launchHasher:hasher];
}

@end
