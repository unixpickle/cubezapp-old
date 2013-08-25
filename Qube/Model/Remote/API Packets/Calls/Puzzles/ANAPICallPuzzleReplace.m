//
//  ANAPIReplaceRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallPuzzleReplace.h"

@implementation ANAPICallPuzzleReplace

- (id)initWithRemoteId:(NSData *)theId puzzle:(ANPuzzle *)localPuzzle {
    NSDictionary * puzzleDict = [localPuzzle encodePuzzle];
    NSDictionary * params = @{@"remoteId": theId, @"puzzle": puzzleDict};
    if ((self = [super initWithAPI:@"puzzles.replace" params:params])) {
    }
    return self;
}

@end
