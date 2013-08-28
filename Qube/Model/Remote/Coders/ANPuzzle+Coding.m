//
//  ANPuzzleEncoder.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzle+Coding.h"

@implementation ANPuzzle (Coding)

+ (NSArray *)puzzleAttributes {
    return @[kANPuzzleAttributeName,
             kANPuzzleAttributeHidden,
             kANPuzzleAttributeIconColor,
             kANPuzzleAttributeImageHash,
             kANPuzzleAttributeInspectionTime,
             kANPuzzleAttributeScramble,
             kANPuzzleAttributeScrambleLen,
             kANPuzzleAttributeSessionLen,
             kANPuzzleAttributeShowScramble,
             kANPuzzleAttributeShowStats,
             kANPuzzleAttributeType];
}

- (NSData *)valueForPuzzleAttribute:(NSString *)attr {
    if ([attr isEqualToString:kANPuzzleAttributeHidden]) {
        UInt8 byte = self.hidden;
        return [NSData dataWithBytes:&byte length:1];
    } else if ([attr isEqualToString:kANPuzzleAttributeIconColor]) {
        return self.iconColor;
    } else if ([attr isEqualToString:kANPuzzleAttributeImageHash]) {
        return self.image;
    } else if ([attr isEqualToString:kANPuzzleAttributeInspectionTime]) {
        NSString * timeStr = [NSString stringWithFormat:@"%lf", self.inspectionTime];
        return [timeStr dataUsingEncoding:NSASCIIStringEncoding];
    } else if ([attr isEqualToString:kANPuzzleAttributeName]) {
        return [self.name dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([attr isEqualToString:kANPuzzleAttributeScramble]) {
        UInt8 byte = self.scramble;
        return [NSData dataWithBytes:&byte length:1];
    } else if ([attr isEqualToString:kANPuzzleAttributeScrambleLen]) {
        NSString * lenStr = [NSString stringWithFormat:@"%d", self.scrambleLength];
        return [lenStr dataUsingEncoding:NSASCIIStringEncoding];
    } else if ([attr isEqualToString:kANPuzzleAttributeShowScramble]) {
        UInt8 byte = self.showSrcamble;
        return [NSData dataWithBytes:&byte length:1];
    } else if ([attr isEqualToString:kANPuzzleAttributeShowStats]) {
        UInt8 byte = self.showStats;
        return [NSData dataWithBytes:&byte length:1];
    } else if ([attr isEqualToString:kANPuzzleAttributeType]) {
        NSString * typeStr = [NSString stringWithFormat:@"%d", self.type];
        return [typeStr dataUsingEncoding:NSASCIIStringEncoding];
    }
    return nil;
}

- (void)setValue:(NSData *)data forPuzzleAttribute:(NSString *)attr {
    if ([attr isEqualToString:kANPuzzleAttributeHidden]) {
        UInt8 byte = *((const UInt8 *)[data bytes]);
        self.hidden = byte;
    } else if ([attr isEqualToString:kANPuzzleAttributeIconColor]) {
        self.iconColor = data;
    } else if ([attr isEqualToString:kANPuzzleAttributeImageHash]) {
        self.image = data;
    } else if ([attr isEqualToString:kANPuzzleAttributeInspectionTime]) {
        NSString * timeStr = [[NSString alloc] initWithData:data
                                                   encoding:NSASCIIStringEncoding];
        self.inspectionTime = [timeStr doubleValue];
    } else if ([attr isEqualToString:kANPuzzleAttributeName]) {
        self.name = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
    } else if ([attr isEqualToString:kANPuzzleAttributeScramble]) {
        UInt8 byte = *((const UInt8 *)[data bytes]);
        self.scramble = byte;
    } else if ([attr isEqualToString:kANPuzzleAttributeScrambleLen]) {
        NSString * lenStr = [[NSString alloc] initWithData:data
                                                  encoding:NSASCIIStringEncoding];
        self.scrambleLength = (int16_t)[lenStr intValue];
    } else if ([attr isEqualToString:kANPuzzleAttributeShowScramble]) {
        UInt8 byte = *((const UInt8 *)[data bytes]);
        self.showSrcamble = byte;
    } else if ([attr isEqualToString:kANPuzzleAttributeShowStats]) {
        UInt8 byte = *((const UInt8 *)[data bytes]);
        self.showStats = byte;
    } else if ([attr isEqualToString:kANPuzzleAttributeType]) {
        NSString * typeStr = [[NSString alloc] initWithData:data
                                                   encoding:NSASCIIStringEncoding];
        self.type = (int16_t)[typeStr intValue];
    }
}

- (NSDictionary *)encodePuzzle {
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    for (NSString * attribute in [self.class puzzleAttributes]) {
        [attributes setObject:[self valueForPuzzleAttribute:attribute]
                       forKey:attribute];
    }
    return @{@"id": self.identifier, @"attributes": attributes};
}

- (void)decodePuzzle:(NSDictionary *)dict withId:(BOOL)idFlag {
    NSDictionary * attributes = [dict objectForKey:@"attributes"];
    if (idFlag) self.identifier = [dict objectForKey:@"id"];
    for (NSString * attr in attributes) {
        [self setValue:[attributes objectForKey:attr] forPuzzleAttribute:attr];
    }
}

@end
