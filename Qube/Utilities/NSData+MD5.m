//
//  NSData+MD5.m
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "NSData+MD5.h"

@implementation NSData (MD5)

- (NSData *)md5Hash {
    unsigned char dest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, self.length, dest);
    return [NSData dataWithBytes:dest length:CC_MD5_DIGEST_LENGTH];
}

@end
