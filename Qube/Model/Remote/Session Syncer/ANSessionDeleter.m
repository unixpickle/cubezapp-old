//
//  ANSessionDeleter.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionDeleter.h"

@interface ANSessionDeleter (Private)

- (void)handleResponse:(NSDictionary *)resp;

@end

@implementation ANSessionDeleter

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aMan delegate:aDel])) {
        NSArray * reqs = [aMan.activeAccount.changes.sessionDeletions array];
        ANAPISessionDeleteRequest * req = [[ANAPISessionDeleteRequest alloc] initWithDeleteRequests:reqs];
        [self sendAPICall:req returnSelector:@selector(handleResponse:)];
        deleteRequests = reqs;
    }
    return self;
}

- (void)handleResponse:(NSDictionary *)resp {
    for (OCSessionDeletion * req in deleteRequests) {
        [manager.context deleteObject:req];
    }
}

@end
