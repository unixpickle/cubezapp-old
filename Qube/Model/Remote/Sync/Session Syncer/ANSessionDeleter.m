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

- (id)initWithDelegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        NSArray * reqs = [manager.activeAccount.changes.sessionDeletions array];
        ANAPICallSessionDeleteRequest * req = [[ANAPICallSessionDeleteRequest alloc] initWithDeleteRequests:reqs];
        [self sendAPICall:req returnSelector:@selector(handleResponse:)];
        
        NSMutableArray * mIds = [NSMutableArray array];
        for (OCSessionDeletion * del in reqs) {
            [mIds addObject:del.identifier];
        }
        theDeleteIds = mIds;
    }
    return self;
}

- (void)handleResponse:(NSDictionary *)resp {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    for (NSData * ident in theDeleteIds) {
        OCSessionDeletion * req = [manager findSessionDeletionForId:ident];
        if (!req) continue;
        [manager.context deleteObject:req];
    }
}

@end
