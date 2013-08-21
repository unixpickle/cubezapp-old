//
//  ANPuzzleEncoder.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANPuzzle.h"

#define kANPuzzleAttributeName @"Name"
#define kANPuzzleAttributeHidden @"Hidden"
#define kANPuzzleAttributeIconColor @"IconColor"
#define kANPuzzleAttributeImageHash @"ImageHash"
#define kANPuzzleAttributeInspectionTime @"InspectionTime"
#define kANPuzzleAttributeScramble @"Scramble"
#define kANPuzzleAttributeScrambleLen @"ScrambleLen"
#define kANPuzzleAttributeSessionLen @"SessionLen"
#define kANPuzzleAttributeShowScramble @"ShowScramble"
#define kANPuzzleAttributeShowStats @"ShowStats"
#define kANPuzzleAttributeType @"Type"


@interface ANPuzzle (Coding)

+ (NSArray *)puzzleAttributes;

- (NSData *)valueForPuzzleAttribute:(NSString *)attr;
- (void)setValue:(NSData *)data forPuzzleAttribute:(NSString *)attr;

- (NSDictionary *)encodePuzzle;
- (void)decodePuzzle:(NSDictionary *)dict withId:(BOOL)idFlag;

@end
