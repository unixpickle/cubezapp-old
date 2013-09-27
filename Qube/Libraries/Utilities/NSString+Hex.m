//
//  NSString+Hex.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "NSString+Hex.h"

static BOOL isHexChar(char c);
static int hexValue(char c);

@implementation NSString (Hex)

- (NSData *)dataFromHex {
    NSMutableData * data = [NSMutableData data];
    if (self.length % 2 != 0) return nil;
    for (int i = 0; i < self.length; i += 2) {
        char c1 = tolower([self characterAtIndex:i]);
        char c2 = tolower([self characterAtIndex:(i + 1)]);
        if (!isHexChar(c1) || !isHexChar(c2)) return nil;
        UInt8 byte = (hexValue(c1) << 4) | (hexValue(c2));
        [data appendBytes:&byte length:1];
    }
    return data;
}

@end

static BOOL isHexChar(char c) {
    if (c >= 'a' && c <= 'f') return YES;
    if (c >= '0' && c <= '9') return YES;
    return NO;
}

static int hexValue(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    return c - 'a' + 10;
}
