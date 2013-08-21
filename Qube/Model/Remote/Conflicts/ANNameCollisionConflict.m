//
//  ANNameCollisionConflict.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANNameCollisionConflict.h"

@implementation ANNameCollisionConflict

- (NSArray *)options {
    NSArray * mergeOptions = @[];
    if ([self allowGeneralMerge]) {
        mergeOptions = @[@"Merge"];
    } else if ([self allowLocalAndRemoteMerge]) {
        mergeOptions = @[@"Merge keeping local settings",
                 @"Merge keeping remote settings"];
    }
    return [@[@"Keep puzzle from cloud",
             @"Keep puzzle from this device",
             @"Rename local puzzle",
             @"Rename remote puzzle"] arrayByAddingObjectsFromArray:mergeOptions];
}

- (NSString *)title {
    return @"A puzzle from the cloud has the same name as a different puzzle on this device.";
}

- (ANConflictInput)inputTypeForOption:(int)index {
    if (index == 2 || index == 3) {
        return ANConflictInputPuzzleName;
    }
    return ANConflictInputSelection;
}

- (BOOL)allowGeneralMerge {
    for (NSString * key in [ANPuzzle puzzleAttributes]) {
        NSData * localAttr = [self.localPuzzle valueForPuzzleAttribute:key];
        NSData * remoteAttr = [self.remotePuzzle attributeValue:key];
        if (![localAttr isEqualToData:remoteAttr]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)allowLocalAndRemoteMerge {
    NSData * type = [self.localPuzzle valueForPuzzleAttribute:kANPuzzleAttributeType];
    NSData * remType = [self.remotePuzzle attributeValue:kANPuzzleAttributeType];
    return [type isEqualToData:remType];
}

- (ANNameCollisionConflictResolution)resolutionForIndex:(int)index {
    return index;
}

@end
