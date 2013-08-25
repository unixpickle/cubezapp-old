//
//  ANAPISessionDeleteRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallSessionDeleteRequest.h"

@implementation ANAPICallSessionDeleteRequest

- (id)initWithIds:(NSArray *)ids {
    self = [super initWithAPI:@"sessions.delete"
                       params:@{@"ids": ids}];
    return self;
}

- (id)initWithDeleteRequests:(NSArray *)deletions {
    NSMutableArray * theIds = [NSMutableArray array];
    for (OCSessionDeletion * del in deletions) {
        [theIds addObject:del.identifier];
    }
    self = [self initWithIds:theIds];
    return self;
}

@end
