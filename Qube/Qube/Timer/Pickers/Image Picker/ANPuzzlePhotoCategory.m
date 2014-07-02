//
//  ANPuzzlePhotoCategory.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzlePhotoCategory.h"

@implementation ANPuzzlePhotoCategory

+ (NSArray *)categories {
    return @[
             [ANPuzzlePhotoCategory categoryWithName:@"Cubes" thumbnail:[UIImage imageNamed:@"default_3x3x3"]
                                               names:@[@"default_2x2x2", @"default_3x3x3", @"default_4x4x4",
                                                       @"default_5x5x5", @"default_6x6x6", @"default_7x7x7",
                                                       @"default_8x8x8", @"default_9x9x9"]],
             [ANPuzzlePhotoCategory categoryWithName:@"Minxes" thumbnail:[UIImage imageNamed:@"default_pyraminx"]
                                               names:@[@"default_pyraminx", @"default_megaminx"]],
             [ANPuzzlePhotoCategory categoryWithName:@"Miscellaneous" thumbnail:[UIImage imageNamed:@"default_clock"]
                                               names:@[@"default_clock", @"default_square1"]]
             ];
}

+ (ANPuzzlePhotoCategory *)categoryWithName:(NSString *)name thumbnail:(UIImage *)thum names:(NSArray *)names {
    ANPuzzlePhotoCategory * category = [[ANPuzzlePhotoCategory alloc] init];
    category.name = name;
    category.thumbnail = thum;
    category.imageNames = names;
    return category;
}

@end
