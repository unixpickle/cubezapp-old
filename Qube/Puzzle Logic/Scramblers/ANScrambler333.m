//
//  ANScrambler33.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANScrambler333.h"

@implementation ANScrambler333

- (id)generateScramble:(NSInteger)len callback:(ANPuzzleScramblerCallback)callback {
    // TODO: do this
    callback(nil, @"R U R'");
    return nil;
}

- (void)cancelScramble:(id)aToken {
    // nothing to do here!
}

+ (NSRange)lengthRange {
    return NSMakeRange(20, 10);
}

+ (NSString *)labelForLength:(NSInteger)length {
    return [NSString stringWithFormat:@"%ld (HTM)", (long)length];
}

@end
