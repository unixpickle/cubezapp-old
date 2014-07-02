//
//  ANPuzzle+Default.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzle+Default.h"

NSData * imageDataForType(ANPuzzleType type);

@implementation ANPuzzle (Default)

- (void)setDefaultFields:(ANPuzzleType)aType {
    // check if they have changed the image
    NSData * imageData = imageDataForType(self.type);
    BOOL shouldChangeImage = NO;
    if ([self.image isEqualToData:[imageData md5Hash]] || !self.image) {
        shouldChangeImage = YES;
    }
    
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
    
    if (shouldChangeImage) {
        imageData = imageDataForType(aType);
        [self offlineSetImage:[[ANImageManager sharedImageManager] registerImageData:imageData]];
    }
}

@end

NSData * imageDataForType(ANPuzzleType type) {
    NSString * rootName = [[PuzzleNames[type] lowercaseString] stringByReplacingOccurrencesOfString:@" "
                                                                                         withString:@"_"];
    NSString * defaultFilename = [NSString stringWithFormat:@"default_%@@2x", rootName];
    NSString * path = [[NSBundle mainBundle] pathForResource:defaultFilename ofType:@"png"];
    return [NSData dataWithContentsOfFile:path];
}
