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

- (id)initWithDelegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        NSArray * settings = [manager.activeAccount.changes.puzzleSettings allObjects];
        ANAPICallPuzzleSet * request = [[ANAPICallPuzzleSet alloc] initWithSettings:settings];
        [self sendAPICall:request returnSelector:@selector(handleSetResponse:)];
    }
    return self;
}

- (void)handleSetResponse:(NSDictionary *)dict {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    ANAPIPuzzleSetResponse * response = [[ANAPIPuzzleSetResponse alloc] initWithDictionary:dict];
    for (OCPuzzleSetting * setting in response.setRequests) {
        [manager.context deleteObject:setting];
    }
}

@end
