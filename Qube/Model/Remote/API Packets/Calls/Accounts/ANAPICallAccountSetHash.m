//
//  ANAPICallAccountSetHash.m
//  Qube
//
//  Created by Alex Nichol on 9/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallAccountSetHash.h"

@implementation ANAPICallAccountSetHash

- (id)initWithOldPassword:(NSString *)old newPassword:(NSString *)newPassword {
    NSData * oldHash = [[old dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
    NSData * newHash = [[newPassword dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
    NSDictionary * request = @{@"username": [ANDataManager sharedDataManager].activeAccount.username,
                               @"hash": oldHash,
                               @"new": newHash};
    self = [super initWithAPI:@"account.setHash" params:request];
    return self;
}

@end
