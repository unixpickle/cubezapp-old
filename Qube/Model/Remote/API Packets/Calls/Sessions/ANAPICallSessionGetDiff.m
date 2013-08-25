//
//  ANAPISessionGetDiff.m
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallSessionGetDiff.h"

@implementation ANAPICallSessionGetDiff

- (id)initWithIdPrefix:(NSData *)query ids:(NSArray *)ids {
    NSDictionary * params = @{@"idPrefix": query, @"ids": ids};
    self = [super initWithAPI:@"sessions.getDiff" params:params];
    return self;
}

- (id)initWithIdPrefix:(NSData *)query sessions:(NSArray *)sessions {
    NSMutableArray * mIds = [NSMutableArray array];
    for (ANSession * session in sessions) {
        [mIds addObject:session.identifier];
    }
    self = [self initWithIdPrefix:query ids:mIds];
    return self;
}

@end
