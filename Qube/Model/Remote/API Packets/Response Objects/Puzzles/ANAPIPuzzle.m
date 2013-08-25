//
//  ANAPIPuzzleObj.m
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIPuzzle.h"

@implementation ANAPIPuzzle

@synthesize dictionary;

- (id)initWithDictionary:(NSDictionary *)aDict {
    if ((self = [super init])) {
        dictionary = aDict;
    }
    return self;
}

- (NSData *)identifier {
    return [dictionary objectForKey:@"id"];
}

- (NSData *)attributeValue:(NSString *)key {
    return [[dictionary objectForKey:@"attributes"] objectForKey:key];
}

@end
