//
//  ANAPIRenameRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallPuzzleRename.h"

@implementation ANAPICallPuzzleRename

- (id)initWithPuzzleSettingChanges:(NSArray *)changes {
    NSMutableArray * renames = [NSMutableArray array];
    for (OCPuzzleSetting * setting in changes) {
        NSAssert([[setting attribute] isEqualToString:kANPuzzleAttributeName],
                 @"Change must be a name change");
        NSDictionary * change = @{@"id": setting.puzzle.identifier,
                                  @"name": setting.puzzle.name};
        [renames addObject:change];
    }
    self = [super initWithAPI:@"puzzles.rename"
                       params:@{@"renames": renames}];
    return self;
}

- (id)initWithPuzzleIds:(NSArray *)ids names:(NSArray *)names {
    NSAssert([ids count] == [names count], @"Count of input arrays must be equal.");
    NSMutableArray * renames = [NSMutableArray array];
    for (int i = 0; i < [ids count]; i++) {
        NSDictionary * change = @{@"id": [ids objectAtIndex:i],
                                  @"name": [names objectAtIndex:i]};
        [renames addObject:change];
    }
    self = [super initWithAPI:@"puzzles.rename"
                       params:@{@"renames": renames}];
    return self;
}

@end
