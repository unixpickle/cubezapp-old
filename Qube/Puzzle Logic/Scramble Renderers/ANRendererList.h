//
//  ANRendererList.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANCubeScrambleRenderer.h"

@interface ANRendererList : NSObject {
    NSArray * renderers;
}

+ (ANRendererList *)defaultRendererList;
- (id)initWithRenderers:(NSArray *)list;

- (id<ANScrambleRenderer>)rendererForPuzzle:(ANPuzzleType)puzzle;

@end
