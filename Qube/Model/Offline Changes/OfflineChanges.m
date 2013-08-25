//
//  OfflineChanges.m
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "OfflineChanges.h"
#import "LocalAccount.h"
#import "OCAccountChange.h"
#import "OCPuzzleAddition.h"
#import "OCPuzzleDeletion.h"
#import "OCPuzzleSetting.h"
#import "OCSessionAddition.h"
#import "OCSessionDeletion.h"


@implementation OfflineChanges

@dynamic accountChanges;
@dynamic localAccount;
@dynamic puzzleAdditions;
@dynamic puzzleDeletions;
@dynamic puzzleSettings;
@dynamic sessionAdditions;
@dynamic sessionDeletions;

@end
