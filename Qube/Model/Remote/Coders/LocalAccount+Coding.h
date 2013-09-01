//
//  LocalAccount+Coding.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "LocalAccount.h"

#define kANAccountAttributeCubeScheme @"CubeScheme"
#define kANAccountAttributeName @"Name"

@interface LocalAccount (Coding)

+ (NSArray *)accountAttributes;
- (NSData *)valueForAccountAttribute:(NSString *)attr;
- (void)setValue:(NSData *)data forAccountAttribute:(NSString *)attr;

- (NSDictionary *)encodeAccount;
- (void)decodeAccount:(NSDictionary *)dict;

@end
