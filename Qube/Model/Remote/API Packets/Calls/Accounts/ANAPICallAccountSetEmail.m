//
//  ANAPICallSetEmail.m
//  Qube
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallAccountSetEmail.h"

@implementation ANAPICallAccountSetEmail

- (id)initWithEmail:(NSString *)email {
    self = [super initWithAPI:@"account.setEmail"
                       params:@{@"email": email}];
    return self;
}

@end
