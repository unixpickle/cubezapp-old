//
//  ANAPIConflictObj.h
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDataManager+Search.h"
#import "ANAPIPuzzle.h"

@interface ANAPIConflict : NSObject

@property (readonly) ANPuzzle * localPuzzle;
@property (readonly) ANAPIPuzzle * remotePuzzle;

- (id)initWithConflictInfo:(NSDictionary *)dictionary;

@end
