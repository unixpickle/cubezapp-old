//
//  ANRendererList.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANRendererList.h"

@implementation ANRendererList

+ (ANRendererList *)defaultRendererList {
    static ANRendererList * list = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * listing = @[[[ANCubeScrambleRenderer alloc] init]];
        list = [[ANRendererList alloc] initWithRenderers:listing];
    });
    return list;
}

- (id)initWithRenderers:(NSArray *)list {
    if ((self = [super init])) {
        renderers = list;
    }
    return self;
}

- (id<ANScrambleRenderer>)rendererForPuzzle:(ANPuzzleType)puzzle {
    for (id<ANScrambleRenderer> aRend in renderers) {
        if ([aRend.class supportsPuzzle:puzzle]) {
            return aRend;
        }
    }
    return nil;
}

@end
