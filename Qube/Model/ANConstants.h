//
//  ANConstants.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#ifndef Qube_ANConstants_h
#define Qube_ANConstants_h

typedef enum {
    ANPuzzleTypeOther = 0,
    ANPuzzleTypeClock,
    ANPuzzleType2x2,
    ANPuzzleType3x3,
    ANPuzzleType4x4,
    ANPuzzleType5x5,
    ANPuzzleType6x6,
    ANPuzzleType7x7,
    ANPuzzleTypeMegaminx,
    ANPuzzleTypePyraminx
} ANPuzzleType;

typedef enum {
    ANSolveRecordStatusDNF = 0,
    ANSolveRecordStatusPopped = 1,
    ANSolveRecordStatusCompleted = 2
} ANSolveRecordStatus;

static NSString * PuzzleNames[] = {
    @"Other",
    @"Clock",
    @"2x2x2",
    @"3x3x3",
    @"4x4x4",
    @"5x5x5",
    @"6x6x6",
    @"7x7x7",
    @"Megaminx",
    @"Pyraminx"
};

#define kANPuzzleTypeCount (sizeof(PuzzleNames) / sizeof(NSString *))

#endif
