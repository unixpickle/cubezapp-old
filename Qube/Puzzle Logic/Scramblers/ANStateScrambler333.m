//
//  ANStateScrambler33.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANStateScrambler333.h"

@implementation ANStateScrambler333

- (id)generateScramble:(NSInteger)length callback:(ANPuzzleScramblerCallback)callback {
    callback([NSError errorWithDomain:@"NYI" code:1 userInfo:nil], nil);
    return nil;
}

- (void)cancelScramble:(id)aToken {
    // nothing, yet
}

+ (NSRange)lengthRange {
    return NSMakeRange(0, 1);
}

+ (NSString *)labelForLength:(NSInteger)length {
    NSAssert(length == 0, @"Invalid length for state scrambler.");
    return @"Random State";
}

@end
