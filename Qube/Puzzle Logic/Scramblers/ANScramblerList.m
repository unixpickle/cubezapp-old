//
//  ANScramblerList.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANScramblerList.h"

@implementation ANScramblerList

+ (ANScramblerList *)defaultScramblerList {
    static ANScramblerList * list = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary * listing = @{
                                   @(ANPuzzleType3x3): @[[[ANStateScrambler333 alloc] init],
                                                         [[ANScrambler333 alloc] init]]
                                   };
        list = [[ANScramblerList alloc] initWithScramblers:listing];
    });
    return list;
}

- (id)initWithScramblers:(NSDictionary *)_scramblers {
    if ((self = [super init])) {
        scramblers = _scramblers;
    }
    return self;
}

- (NSArray *)scramblersForPuzzle:(ANPuzzleType)type {
    return [scramblers objectForKey:@(type)];
}

- (NSArray *)scramblerNamesForPuzzle:(ANPuzzleType)type {
    NSArray * list = [self scramblersForPuzzle:type];
    NSMutableArray * result = [NSMutableArray array];
    
    for (id<ANPuzzleScrambler> scrambler in list) {
        NSRange range = [scrambler.class lengthRange];
        for (NSUInteger i = range.location; i < range.location + range.length; i++) {
            [result addObject:[scrambler.class labelForLength:i]];
        }
    }
    
    return [result copy];
}

- (id<ANPuzzleScrambler>)scramblerForPuzzle:(ANPuzzleType)type length:(NSInteger)len {
    NSArray * list = [self scramblersForPuzzle:type];
    if (!list) return nil;
    for (id<ANPuzzleScrambler> scrambler in list) {
        NSRange range = [scrambler.class lengthRange];
        if (len >= range.location && len < range.location + range.length) {
            return scrambler;
        }
    }
    return nil;
}

- (id<ANPuzzleScrambler>)scramblerForPuzzle:(ANPuzzleType)type name:(NSString *)name length:(NSInteger *)lenOut {
    NSArray * list = [self scramblersForPuzzle:type];
    
    for (id<ANPuzzleScrambler> scrambler in list) {
        NSRange range = [scrambler.class lengthRange];
        for (NSUInteger i = range.location; i < range.location + range.length; i++) {
            NSString * aName = [scrambler.class labelForLength:i];
            if ([aName isEqualToString:name]) {
                *lenOut = (NSInteger)i;
                return scrambler;
            }
        }
    }
    
    return nil;
}

@end
