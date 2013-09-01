//
//  ANAPICallSignup.m
//  Qube
//
//  Created by Alex Nichol on 8/31/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallSignup.h"

@implementation ANAPICallSignup

- (id)initWithUsername:(NSString *)username
                  hash:(NSData *)hash
                 email:(NSString *)email
                scheme:(ANCubeScheme *)scheme
                  name:(NSString *)name {
    NSDictionary * dict = @{@"username": username,
                            @"hash": hash,
                            @"email": email,
                            @"attributes": @{kANAccountAttributeCubeScheme: [scheme encode],
                                             kANAccountAttributeName: [name dataUsingEncoding:NSUTF8StringEncoding]}};
    self = [super initWithAPI:@"account.signup" params:dict];
    return self;
}

@end
