//
//  ANAddRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallPuzzleAdd.h"

@implementation ANAPICallPuzzleAdd

+ (NSDictionary *)encodeWithPuzzles:(NSArray *)puzzles {
    NSMutableArray * additionRequests = [[NSMutableArray alloc] init];
    for (ANPuzzle * puzzle in puzzles) {
        [additionRequests addObject:puzzle.encodePuzzle];
    }
    return @{@"puzzles": additionRequests};
}

- (id)initWithPuzzleAdditions:(NSArray *)additions {
    NSMutableArray * puzzleList = [NSMutableArray array];
    for (OCPuzzleAddition * addition in additions) {
        [puzzleList addObject:addition.puzzle];
    }
    if ((self = [super initWithAPI:@"puzzles.add"
                            params:[self.class encodeWithPuzzles:puzzleList]])) {
    }
    return self;
}

- (id)initWithPuzzles:(NSArray *)_puzzles {
    if ((self = [super initWithAPI:@"puzzles.add"
                            params:[self.class encodeWithPuzzles:_puzzles]])) {
    }
    return self;
}

@end
