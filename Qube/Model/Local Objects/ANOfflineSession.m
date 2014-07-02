//
//  ANOfflineSession.m
//  Qube
//
//  Created by Alex Nichol on 10/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANOfflineSession.h"

@implementation ANOfflineSession

@synthesize solves = _solves;
@synthesize scrambler = _scrambler;
@synthesize renderer = _renderer;

- (id)initWithPuzzle:(ANPuzzle *)aPuzzle {
    if ((self = [super init])) {
        _solves = [NSMutableArray array];
        self.puzzle = aPuzzle;
        if (aPuzzle.scramble) {
            _scrambler = [[ANScramblerList defaultScramblerList] scramblerForPuzzle:aPuzzle.type
                                                                             length:aPuzzle.scrambleLength];
        }
        if (aPuzzle.showScramble) {
            _renderer = [[ANRendererList defaultRendererList] rendererForPuzzle:aPuzzle.type];
        }
    }
    return self;
}

@end
