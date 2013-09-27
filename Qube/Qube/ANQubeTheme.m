//
//  ANQubeTheme.m
//  Qube
//
//  Created by Alex Nichol on 9/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANQubeTheme.h"

@implementation ANQubeTheme

+ (UIColor *)lightBackgroundColor {
    return [UIColor colorWithWhite:0.9215686275 alpha:1];
}

+ (NSArray *)supportedGridColors {
    return @[
             @{@"name": @"Purple", @"color": [UIColor colorWithRed:0.8 green:0.4509803922 blue:0.8823529412 alpha:1]},
             @{@"name": @"Green", @"color": [UIColor colorWithRed:0.3882352941 green:0.8549019608 blue:0.2196078431 alpha:1]},
             @{@"name": @"Blue", @"color": [UIColor colorWithRed:0.1058823529 green:0.6784313725 blue:0.9725490196 alpha:1]},
             @{@"name": @"Yellow", @"color": [UIColor colorWithRed:0.9176470588 green:0.7333333333 blue:0 alpha:1]},
             @{@"name": @"Brown", @"color": [UIColor colorWithRed:0.6352941176 green:0.5176470588 blue:0.368627451 alpha:1]},
             @{@"name": @"Red", @"color": [UIColor colorWithRed:1 green:0.1607843137 blue:0.4078431373 alpha:1]},
             @{@"name": @"Orange", @"color": [UIColor colorWithRed:1 green:0.5843137255 blue:0 alpha:1]}
             ];
}

@end
