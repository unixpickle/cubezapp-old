//
//  NSData+Random.m
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "NSData+Random.h"

@implementation NSData (Random)

+ (NSData *)randomDataOfLength:(NSInteger)len {
    NSMutableData * data = [NSMutableData data];
    for (NSInteger i = 0; i < len / 4; i++) {
        uint32_t number = arc4random();
        [data appendBytes:&number length:4];
    }
    if (len % 4) {
        uint32_t random = arc4random();
        [data appendBytes:&random length:(len % 4)];
    }
    return [data copy];
}

@end
