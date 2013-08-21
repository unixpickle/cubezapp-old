//
//  ANNameCollisionConflict.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANConflict.h"
#import "ANPuzzle+Coding.h"
#import "ANAPIPuzzle.h"

typedef enum {
    ANNameCollisionConflictResolutionKeepRemote = 0,
    ANNameCollisionConflictResolutionKeepLocal,
    ANNameCollisionConflictResolutionRenameLocal,
    ANNameCollisionConflictResolutionRenameRemote,
    ANNameCollisionConflictResolutionMergeLocalSettings, // also used for regular merge
    ANNameCollisionConflictResolutionMergeRemoteSettings
} ANNameCollisionConflictResolution;

@interface ANNameCollisionConflict : ANConflict

@property (nonatomic, retain) ANAPIPuzzle * remotePuzzle;
@property (nonatomic, retain) ANPuzzle * localPuzzle;

- (BOOL)allowGeneralMerge;
- (BOOL)allowLocalAndRemoteMerge;
- (ANNameCollisionConflictResolution)resolutionForIndex:(int)index;

@end
