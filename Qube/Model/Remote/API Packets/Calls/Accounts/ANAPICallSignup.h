//
//  ANAPICallSignup.h
//  Qube
//
//  Created by Alex Nichol on 8/31/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIBaseCall.h"
#import "ANCubeScheme.h"
#import "LocalAccount+Coding.h"

@interface ANAPICallSignup : ANAPIBaseCall

- (id)initWithUsername:(NSString *)username
                  hash:(NSData *)hash
                 email:(NSString *)email
                scheme:(ANCubeScheme *)scheme
                  name:(NSString *)name;

@end
