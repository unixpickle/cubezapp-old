//
//  ANRenameCollisionConflict.h
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANNameCollisionConflict.h"
#import "ANPuzzle.h"
#import "ANAPIPuzzle.h"

// this class is a name collision conflict which
// does not allow the user to `merge` puzzles
@interface ANRenameCollisionConflict : ANNameCollisionConflict {
    ANPuzzle * localPuzzle;
    ANAPIPuzzle * remotePuzzle;
}

@end
