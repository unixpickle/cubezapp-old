//
//  ANDataManager+Utility.h
//  Qube
//
//  Created by Alex Nichol on 9/27/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager.h"

@interface ANDataManager (Utility)

- (ANPuzzle *)createUnownedPuzzleObject;
- (ANPuzzle *)addUnownedPuzzleObject:(ANPuzzle *)puzzle;

@end
