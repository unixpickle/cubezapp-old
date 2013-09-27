//
//  ANPuzzle+Default.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzle+Default.h"

@implementation ANPuzzle (Default)

- (void)setDefaultFields:(ANPuzzleType)aType {
    NSDictionary * scrambleLengths = @{@(ANPuzzleTypeOther): @0,
                                       @(ANPuzzleTypeClock): @0,
                                       @(ANPuzzleType2x2): @15,
                                       @(ANPuzzleType3x3): @25,
                                       @(ANPuzzleType4x4): @30,
                                       @(ANPuzzleType5x5): @40,
                                       @(ANPuzzleType6x6): @50,
                                       @(ANPuzzleType7x7): @60,
                                       @(ANPuzzleTypePyraminx): @0,
                                       @(ANPuzzleTypeMegaminx): @0};
    [self offlineSetScrambleLength:[scrambleLengths[@(aType)] shortValue]];
    [self offlineSetType:aType];
    [self offlineSetShowStats:YES];
    
    BOOL canScramble = [ANScramblerList.defaultScramblerList scramblersForPuzzle:aType] != nil;
    [self offlineSetScramble:canScramble];
    if (canScramble) {
        BOOL canShow = [ANRendererList.defaultRendererList rendererForPuzzle:aType] != nil;
        [self offlineSetShowScramble:canShow];
    } else {
        [self offlineSetShowScramble:NO];
    }
    
    NSString * rootName = [[PuzzleNames[aType] lowercaseString] stringByReplacingOccurrencesOfString:@" "
                                                                                          withString:@"_"];
    NSString * defaultFilename = [NSString stringWithFormat:@"default_%@@2x", rootName];
    NSString * path = [[NSBundle mainBundle] pathForResource:defaultFilename ofType:@"png"];
    NSData * imageData = [NSData dataWithContentsOfFile:path];
    [self offlineSetImage:[[ANImageManager sharedImageManager] registerImageData:imageData]];
}

@end
