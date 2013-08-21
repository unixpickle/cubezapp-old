//
//  ANAPICall.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAPICall : NSObject {
    NSString * api;
    NSDictionary * parameters;
}

- (id)initWithAPI:(NSString *)theApi params:(NSDictionary *)params;
- (void)fetchResponse:(void (^)(NSError * error, NSDictionary * obj))callback;
- (void)cancel;

@end
