//
//  ANSessionCoder.m
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSession+Coding.h"

@implementation ANSession (Coding)

- (NSDictionary *)encodeSession {
    NSMutableArray * solves = [NSMutableArray array];
    
    for (ANSolve * solve in self.solves) {
        NSDictionary * solveDict = @{@"scramble": solve.scramble,
                                     @"date": [NSNumber numberWithDouble:solve.startDate],
                                     @"status": [NSNumber numberWithShort:solve.status],
                                     @"time": [NSNumber numberWithDouble:solve.time]};
        [solves addObject:solveDict];
    }
    
    return @{@"puzzleId": self.puzzle.identifier, @"id": self.identifier,
             @"solves": solves};
}

- (void)decodeSession:(NSDictionary *)dict {
    while ([self.solves count] > 0) [self removeObjectFromSolvesAtIndex:0];
    for (NSDictionary * solveObj in dict) {
        ANSolve * solve = [[ANDataManager sharedDataManager] createSolveObject];
        [self addSolvesObject:solve];
        solve.time = [[solveObj objectForKey:@"time"] doubleValue];
        solve.status = [[solveObj objectForKey:@"status"] shortValue];
        solve.startDate = [[solveObj objectForKey:@"date"] doubleValue];
        solve.scramble = [solveObj objectForKey:@"scramble"];
    }
    self.identifier = [dict objectForKey:@"id"];
}

@end
