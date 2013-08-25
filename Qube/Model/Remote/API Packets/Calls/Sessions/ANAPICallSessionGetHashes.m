//
//  ANAPISessionGetHashes.m
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallSessionGetHashes.h"

@implementation ANAPICallSessionGetHashes

- (id)initWithIdPrefix:(NSData *)query prefLen:(NSInteger)prefLen {
    NSDictionary * req = @{@"idPrefix": query, @"length": [NSNumber numberWithInteger:prefLen]};
    self = [super initWithAPI:@"sessions.getHashes" params:req];
    return self;
}

@end
