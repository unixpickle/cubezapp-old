//
//  LocalAccount+Coding.m
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "LocalAccount+Coding.h"

@implementation LocalAccount (Coding)

+ (NSArray *)accountAttributes {
    return @[kANAccountAttributeName, kANAccountAttributeCubeScheme];
}

- (NSData *)valueForAccountAttribute:(NSString *)attr {
    if ([attr isEqualToString:kANAccountAttributeName]) {
        return [self.name dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([attr isEqualToString:kANAccountAttributeCubeScheme]) {
        return self.cubeScheme;
    }
    return nil;
}

- (void)setValue:(NSData *)data forAccountAttribute:(NSString *)attr {
    if ([attr isEqualToString:kANAccountAttributeName]) {
        self.name = [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding];
        if (!self.name) {
            NSLog(@"error setting name using unicode");
            self.name = @"no name";
        }
    } else if ([attr isEqualToString:kANAccountAttributeCubeScheme]) {
        self.cubeScheme = data;
    }
}

#pragma mark - Encoding API -

- (NSDictionary *)encodeAccount {
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for (NSString * attr in [self.class accountAttributes]) {
        [dict setObject:[self valueForAccountAttribute:attr]
                 forKey:attr];
    }
    return @{@"email": self.email,
             @"attributes": dict};
}

- (void)decodeAccount:(NSDictionary *)dict {
    self.email = [dict objectForKey:@"email"];
    for (NSString * attr in [self.class accountAttributes]) {
        NSData * remVal = [[dict objectForKey:@"attributes"] objectForKey:attr];
        [self setValue:remVal forAccountAttribute:attr];
    }
}

@end
