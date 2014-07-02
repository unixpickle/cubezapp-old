//
//  ANOfflineSession.h
//  Qube
//
//  Created by Alex Nichol on 10/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANPuzzle.h"
#import "ANScramblerList.h"
#import "ANRendererList.h"

@interface ANOfflineSession : NSObject

@property (readonly) NSMutableArray * solves;
@property (nonatomic, retain) ANPuzzle * puzzle;
@property (readonly) id<ANPuzzleScrambler> scrambler;
@property (readonly) id<ANScrambleRenderer> renderer;

- (id)initWithPuzzle:(ANPuzzle *)puzzle;

@end
