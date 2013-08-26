//
//  NSData+Hex.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "NSData+Hex.h"

@implementation NSData (Hex)

- (NSString *)hexRepresentation {
    NSMutableString * string = [NSMutableString string];
    
    const UInt8 * data = (const UInt8 *)[self bytes];
    for (int i = 0; i < self.length; i++) {
        [string appendFormat:@"%02x", data[i]];
    }
    
    return string;
}

@end
