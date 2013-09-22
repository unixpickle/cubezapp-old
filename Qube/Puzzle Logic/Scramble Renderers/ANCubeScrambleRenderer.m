//
//  ANCubeScrambleRenderer.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANCubeScrambleRenderer.h"

@implementation ANCubeScrambleRenderer

+ (BOOL)supportsPuzzle:(ANPuzzleType)type {
    NSArray * supported = @[@(ANPuzzleType2x2), @(ANPuzzleType3x3), @(ANPuzzleType4x4), @(ANPuzzleType5x5),
                            @(ANPuzzleType6x6), @(ANPuzzleType7x7)];
    return [supported containsObject:@(type)];
}

- (ANImageObj *)imageForScramble:(NSString *)scramble puzzle:(ANPuzzleType)type {
    // TODO: make this work using some perspective logic
    return nil;
}

@end
