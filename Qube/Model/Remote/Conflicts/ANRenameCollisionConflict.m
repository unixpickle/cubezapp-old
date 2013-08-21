//
//  ANRenameCollisionConflict.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANRenameCollisionConflict.h"

@implementation ANRenameCollisionConflict

- (BOOL)allowGeneralMerge {
    return NO;
}

- (BOOL)allowLocalAndRemoteMerge {
    return NO;
}

@end
