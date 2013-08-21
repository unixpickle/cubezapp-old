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
    if ((self = [super init])) {
        api = theApi;
        parameters = params;
    }
    return self;
}

- (void)fetchResponse:(void (^)(NSError * error, NSDictionary * obj))callback {
    callback([NSError errorWithDomain:@"NYI" code:0 userInfo:nil], nil);
}

- (void)cancel {
    
}

@end
