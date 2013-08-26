//
//  ANAPIImageDownloadResponse.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIImageDownloadResponse.h"

@implementation ANAPIImageDownloadResponse

@synthesize hash, data;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        hash = [dictionary objectForKey:@"hash"];
        data = [dictionary objectForKey:@"data"];
    }
    return self;
}

@end
