//
//  ANPuzzleSetter.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleSetter.h"

@interface ANPuzzleSetter (Private)

- (void)handleSetResponse:(NSDictionary *)response;

@end

@implementation ANPuzzleSetter

- (id)initWithDataManager:(ANDataManager *)aManager delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aManager delegate:aDel])) {
        NSArray * settings = [manager.activeAccount.changes.puzzleSettings array];
        ANAPISetRequest * request = [[ANAPISetRequest alloc] initWithSettings:settings];
        [self sendAPICall:request returnSelector:@selector(handleSetResponse:)];
    }
    return self;
}

- (void)handleSetResponse:(NSDictionary *)dict {
    ANAPISetResponse * response = [[ANAPISetResponse alloc] initWithDictionary:dict];
    for (OCPuzzleSetting * setting in response.setRequests) {
        [manager.context deleteObject:setting];
    }
}

@end
