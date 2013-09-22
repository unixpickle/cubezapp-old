//
//  Color+HexValue.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "Color+HexValue.h"

@implementation ColorClass (HexValue)

- (void)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue {
#if TARGET_OS_IPHONE
    [self getRed:red green:green blue:blue alpha:NULL];
#else
    ColorClass * rgbColor = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    const CGFloat * comps = CGColorGetComponents(rgbColor.CGColor);
    *red = comps[0];
    *green = comps[1];
    *blue = comps[2];
#endif
}

- (NSString *)hexValue {
    CGFloat red, green, blue;
    [self getRed:&red green:&green blue:&blue];
    return [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned int)(red * 256.0),
            (unsigned int)(green * 256.0),
            (unsigned int)(blue * 256.0)];
}

+ (id)colorWithHexValue:(NSString *)value {
    if ([value length] != 7) return nil;
    CGFloat components[3];
    for (int i = 0; i < 3; i++) {
        NSString * code = [value substringWithRange:NSMakeRange(1 + i * 2, 2)];
        NSScanner * scanner = [NSScanner scannerWithString:code];
        unsigned int decoded = 0;
        if (![scanner scanHexInt:&decoded]) return nil;
        components[i] = ((CGFloat)decoded / 256.0);
    }
#if TARGET_OS_IPHONE
    return [ColorClass colorWithRed:components[0]
                              green:components[1]
                               blue:components[2]
                              alpha:1];
#else
    return [ColorClass colorWithCalibratedRed:components[0]
                                        green:components[1]
                                         blue:components[2]
                                        alpha:1];
#endif
}

- (NSData *)hexValueData {
    return [[self hexValue] dataUsingEncoding:NSASCIIStringEncoding];
}

+ (id)colorWithHexValueData:(NSData *)data {
    NSString * string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return [self colorWithHexValue:string];
}

@end
