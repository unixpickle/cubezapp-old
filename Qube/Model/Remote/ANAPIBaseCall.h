//
//  ANAPIBaseCall.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBEncodeObjC.h"
#import "KBDecodeObjC.h"

#if TARGET_OS_IPHONE
#define kANAPIBaseCallDevice @"ios"
#else
#define kANAPIBaseCallDevice @"mac"
#endif

#define kANAPIBaseCallURL [NSURL URLWithString:@"http://localhost:1234/api"]

typedef void (^ANAPIBaseCallCallback)(NSError * error, NSDictionary * obj);

@interface ANAPIBaseCall : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSString * api;
    NSDictionary * parameters;
    NSURLConnection * connection;
    
    ANAPIBaseCallCallback callback;
    NSMutableData * responseData;
    int statusCode;
}

- (id)initWithAPI:(NSString *)theApi params:(NSDictionary *)params;
- (void)fetchResponse:(void (^)(NSError * error, NSDictionary * obj))callback;
- (void)cancel;

@end
