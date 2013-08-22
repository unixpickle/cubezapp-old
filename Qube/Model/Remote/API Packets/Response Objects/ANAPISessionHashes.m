//
//  ANAPISessionHashes.m
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPISessionHashes.h"

@implementation ANAPISessionHashes

@synthesize hashes;
@synthesize prefLen;
@synthesize idPrefix;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        hashes = [dict objectForKey:@"hashes"];
        prefLen = [[dict objectForKey:@"length"] integerValue];
        idPrefix = [dict objectForKey:@"idPrefix"];
    }
    return self;
}

@end
