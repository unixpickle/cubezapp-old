//
//  ANCubeScheme.m
//  Qube
//
//  Created by Alex Nichol on 8/31/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANCubeScheme.h"

#if TARGET_OS_IPHONE
#define ColorClass UIColor
#else
#define ColorClass NSColor
#endif

@interface ANCubeScheme (Private)

- (NSString *)encodeRGBColor:(ColorClass *)color;
- (ColorClass *)decodeRGBColor:(NSString *)value;

@end

@implementation ANCubeScheme

@synthesize cornerRadius;
@synthesize edgeRadius;
@synthesize baseRadius;
@synthesize vectorX, vectorY, vectorZ, angle;
@synthesize faceColors;

- (id)init {
    if ((self = [super init])) {
        vectorX = 1.0 / sqrt(3);
        vectorY = 1.0 / sqrt(3);
        vectorZ = 1.0 / sqrt(3);
        angle = M_PI / 8;
        faceColors = @[[self decodeRGBColor:@"#00FF00"],
                       [self decodeRGBColor:@"#0000FF"],
                       [self decodeRGBColor:@"#FFFFFF"],
                       [self decodeRGBColor:@"#FFFF00"],
                       [self decodeRGBColor:@"#FF0000"],
                       [self decodeRGBColor:@"#FF0088"]];
        baseRadius = 0.1;
    }
    return self;
}

- (id)initWithData:(NSData *)data {
    if ((self = [super init])) {
        NSDictionary * dict = (NSDictionary *)kb_decode_full(data);
        if (![dict isKindOfClass:[NSDictionary class]]) return nil;
        cornerRadius = [[dict objectForKey:@"cornerRadius"] doubleValue];
        edgeRadius = [[dict objectForKey:@"edgeRadius"] doubleValue];
        baseRadius = [[dict objectForKey:@"baseRadius"] doubleValue];
        NSAssert([[dict objectForKey:@"vector"] count] == 3, @"Invalid dimension of vector.");
        vectorX = [[[dict objectForKey:@"vector"] objectAtIndex:0] doubleValue];
        vectorY = [[[dict objectForKey:@"vector"] objectAtIndex:1] doubleValue];
        vectorZ = [[[dict objectForKey:@"vector"] objectAtIndex:2] doubleValue];
        angle = [[dict objectForKey:@"angle"] doubleValue];
        NSMutableArray * mColors = [NSMutableArray array];
        for (NSString * colorCode in [dict objectForKey:@"faceColors"]) {
            [mColors addObject:[self decodeRGBColor:colorCode]];
        }
        faceColors = [mColors copy];
    }
    return self;
}

- (NSData *)encode {
    NSMutableArray * colorCodes = [NSMutableArray array];
    for (ColorClass * color in faceColors) {
        [colorCodes addObject:[self encodeRGBColor:color]];
    }
    NSDictionary * dict = @{@"cornerRadius": [NSNumber numberWithDouble:self.cornerRadius],
                            @"edgeRadius": [NSNumber numberWithDouble:self.edgeRadius],
                            @"baseRadius": [NSNumber numberWithDouble:self.baseRadius],
                            @"vector": @[[NSNumber numberWithDouble:vectorX],
                                         [NSNumber numberWithDouble:vectorY],
                                         [NSNumber numberWithDouble:vectorZ]],
                            @"angle": [NSNumber numberWithDouble:angle],
                            @"faceColors": colorCodes};
    return kb_encode_full(dict);
}

#pragma mark - Private -

- (NSString *)encodeRGBColor:(ColorClass *)color {
    CGFloat red, green, blue;
#if TARGET_OS_IPHONE
    [color getRed:&red green:&green blue:&blue alpha:NULL];
#else
    ColorClass * rgbColor = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    const CGFloat * comps = CGColorGetComponents(rgbColor.CGColor);
    red = comps[0];
    green = comps[1];
    blue = comps[2];
#endif
    return [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned int)(red * 256.0),
            (unsigned int)(green * 256.0),
            (unsigned int)(blue * 256.0)];
}

- (ColorClass *)decodeRGBColor:(NSString *)value {
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

@end
