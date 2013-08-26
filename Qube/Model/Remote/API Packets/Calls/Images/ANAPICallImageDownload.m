//
//  ANAPICallImagesDownload.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallImageDownload.h"

@implementation ANAPICallImageDownload

- (id)initWithHash:(NSData *)hash {
    self = [super initWithAPI:@"image.download"
                       params:@{@"hash": hash}];
    return self;
}

@end
