//
//  ANAPIBaseCall.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIBaseCall.h"

@implementation ANAPIBaseCall

- (id)initWithAPI:(NSString *)theApi params:(NSDictionary *)params {
    if ((self = [super init])) {
        api = theApi;
        parameters = params;
    }
    return self;
}

- (void)fetchResponse:(ANAPIBaseCallCallback)aCallback {
    // note that everything assumes that NSURLConnection retains
    // its delegate; if it doesn't do that, we're pretty much screwed.
    callback = aCallback;
    responseData = [[NSMutableData alloc] init];
    
    NSMutableDictionary * object = [parameters mutableCopy];
    [object setObject:kANAPIBaseCallDevice forKey:@"device"];
    NSDictionary * call = @{@"call": api, @"object": object};
    
    NSData * sendData = kb_encode_full(call);
    NSString * lenField = [NSString stringWithFormat:@"%lu",
                           (unsigned long)sendData.length];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:kANAPIBaseCallURL
                                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                             timeoutInterval:30];
    [request setHTTPBody:sendData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/keyedbits" forHTTPHeaderField:@"Content-Type"];
    [request setValue:lenField forHTTPHeaderField:@"Content-Length"];
    connection = [[NSURLConnection alloc] initWithRequest:request
                                                 delegate:self
                                         startImmediately:YES];
}

- (void)cancel {
    [connection cancel];
    connection = nil;
}

#pragma mark - URL Connection -

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    statusCode = [(NSHTTPURLResponse *)response statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
    callback(error, nil);
    callback = nil;
    connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    NSDictionary * dictionary = (NSDictionary *)kb_decode_full(responseData);
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        dictionary = @{@"error": @"Invalid returned datatype"};
        statusCode = 0;
    }
    if (statusCode != 200) {
        NSString * errorDesc = [dictionary objectForKey:@"error"];
        if (![errorDesc isKindOfClass:[NSString class]]) errorDesc = @"Unknown error";
        NSDictionary * info = @{NSLocalizedDescriptionKey: errorDesc};
        callback([NSError errorWithDomain:@"ANAPIBaseCall" code:1 userInfo:info], nil);
    } else {
        callback(nil, dictionary);
    }
    callback = nil;
    connection = nil;
}

@end
