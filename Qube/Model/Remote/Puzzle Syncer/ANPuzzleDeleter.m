//
//  ANPuzzleDeleter.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleDeleter.h"

@interface ANPuzzleDeleter (Private)

- (void)handleResponse:(NSDictionary *)resp;

@end

@implementation ANPuzzleDeleter

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aMan delegate:aDel])) {
        LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
        OfflineChanges * changes = account.changes;
        NSMutableArray * deleteIds = [NSMutableArray array];
        for (OCPuzzleDeletion * deletion in changes.puzzleDeletions) {
            [deleteIds addObject:[deletion identifier]];
        }
        ANAPIDeleteRequest * req =  [[ANAPIDeleteRequest alloc] initWithPuzzleIds:deleteIds];
        deleteRequests = deleteIds;
        [self sendAPICall:req returnSelector:@selector(handleResponse:)];
    }
    return self;
}

- (void)handleResponse:(NSDictionary *)resp {
    for (OCPuzzleDeletion * deletion in deleteRequests) {
        [[ANDataManager sharedDataManager].context deleteObject:deletion];
    }
}

@end
