//
//  ANCubeScheme.m
//  Qube
//
//  Created by Alex Nichol on 8/31/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANCubeScheme.h"

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
        faceColors = @[[ColorClass colorWithHexValue:@"#00FF00"],
                       [ColorClass colorWithHexValue:@"#0000FF"],
                       [ColorClass colorWithHexValue:@"#FFFFFF"],
                       [ColorClass colorWithHexValue:@"#FFFF00"],
                       [ColorClass colorWithHexValue:@"#FF0000"],
                       [ColorClass colorWithHexValue:@"#FF0088"]];
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
            [mColors addObject:[ColorClass colorWithHexValue:colorCode]];
        }
        faceColors = [mColors copy];
    }
    return self;
}

- (NSData *)encode {
    NSMutableArray * colorCodes = [NSMutableArray array];
    for (ColorClass * color in faceColors) {
        [colorCodes addObject:[color hexValue]];
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

@end
