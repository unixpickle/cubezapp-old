//
//  ANSessionAdder.m
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionAdder.h"

@interface ANSessionAdder (Private)

- (void)handleAddResponse:(NSDictionary *)resp;

@end

@implementation ANSessionAdder

- (id)initWithDelegate:(id<ANSessionSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        NSArray * adds = [manager.activeAccount.changes.sessionAdditions allObjects];
        ANAPICallSessionAdd * req = [[ANAPICallSessionAdd alloc] initWithAddRequests:adds];
        [self sendAPICall:req returnSelector:nil];
    }
    return self;
}

- (void)handleAddResponse:(NSDictionary *)respObj {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    ANAPISessionAddResponse * resp = [[ANAPISessionAddResponse alloc] initWithDictionary:respObj];
    for (ANSession * session in resp.sessions) {
        if (!session.ocAddition) continue;
        [manager.context deleteObject:session.ocAddition];
    }
}

@end
