//
//  ANScramblerList.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANConstants.h"

#import "ANScrambler333.h"
#import "ANStateScrambler333.h"

@interface ANScramblerList : NSObject {
    NSDictionary * scramblers;
}

+ (ANScramblerList *)defaultScramblerList;
- (id)initWithScramblers:(NSDictionary *)scramblers;

- (NSArray *)scramblersForPuzzle:(ANPuzzleType)type;
- (NSArray *)scramblerNamesForPuzzle:(ANPuzzleType)type;

- (id<ANPuzzleScrambler>)scramblerForPuzzle:(ANPuzzleType)type length:(NSInteger)len;
- (id<ANPuzzleScrambler>)scramblerForPuzzle:(ANPuzzleType)type name:(NSString *)name length:(NSInteger *)lenOut;

@end
