//
//  ANAPICallImageUpload.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallImageUpload.h"

@implementation ANAPICallImageUpload

- (id)initWithHash:(NSData *)hash data:(NSData *)data {
    self = [super initWithAPI:@"image.download"
                       params:@{@"hash": hash, @"data": data}];
    return self;
}

@end
