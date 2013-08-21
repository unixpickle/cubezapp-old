//
//  ANConflict.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANConflict.h"

@implementation ANConflict

- (NSArray *)options {
    return nil;
}

- (NSString *)title {
    return nil;
}

- (ANConflictInput)inputTypeForOption:(int)index {
    return ANConflictInputSelection;
}

@end
