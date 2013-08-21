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

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANSessionSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aMan delegate:aDel])) {
        NSArray * adds = [aMan.activeAccount.changes.sessionAdditions array];
        ANAPISessionAddRequest * req = [[ANAPISessionAddRequest alloc] initWithAddRequests:adds];
        [self sendAPICall:req returnSelector:nil];
    }
    return self;
}

- (void)handleAddResponse:(NSDictionary *)respObj {
    ANAPISessionAddResponse * resp = [[ANAPISessionAddResponse alloc] initWithDictionary:respObj];
    for (ANSession * session in resp.sessions) {
        if (!session.ocAddition) continue;
        [manager.context deleteObject:session.ocAddition];
    }
}

@end
