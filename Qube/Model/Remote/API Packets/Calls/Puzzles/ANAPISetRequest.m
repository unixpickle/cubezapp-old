//
//  ANAPISetRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPISetRequest.h"

@implementation ANAPISetRequest

- (id)initWithSettings:(NSArray *)settings {
    NSMutableArray * settingDicts = [NSMutableArray array];
    for (OCPuzzleSetting * setting in settings) {
        NSDictionary * dict = @{@"id": setting.puzzle.identifier,
                                @"attribute": setting.attribute,
                                @"value": setting.attributeValue};
        [settingDicts addObject:dict];
    }
    self = [super initWithAPI:@"puzzles.setValues"
                       params:@{@"sets": settingDicts}];
    return self;
}

@end
