//
//  ANAPIAccountSet.m
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallAccountSet.h"

@implementation ANAPICallAccountSet

- (id)initWithAccountChanges:(NSArray *)changes {
    NSMutableArray * dicts = [NSMutableArray array];
    for (OCAccountChange * change in changes) {
        [dicts addObject:@{@"attribute": change.attribute,
                           @"value": change.attributeValue}];
    }
    self = [super initWithAPI:@"account.setValues"
                       params:@{@"attributes": dicts}];
    return self;
}

@end
