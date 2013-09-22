//
//  ANScrambleRenderer.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANConstants.h"
#import "OSCommonImage.h"

@protocol ANScrambleRenderer <NSObject>

+ (BOOL)supportsPuzzle:(ANPuzzleType)type;
- (ANImageObj *)imageForScramble:(NSString *)scramble puzzle:(ANPuzzleType)type;

@end
