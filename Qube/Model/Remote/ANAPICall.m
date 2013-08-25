//
//  ANAPICall.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"

@implementation ANAPICall

- (id)initWithAPI:(NSString *)theApi params:(NSDictionary *)params {
    NSMutableDictionary * paramsDict = [params mutableCopy];
    [paramsDict setObject:[ANDataManager sharedDataManager].activeAccount.username
                   forKey:@"username"];
    [paramsDict setObject:[ANDataManager sharedDataManager].activeAccount.passwordmd5
                   forKey:@"hash"];
    self = [super initWithAPI:theApi params:paramsDict];
    return self;
}

@end
