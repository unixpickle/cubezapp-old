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

- (id)initWithDelegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        LocalAccount * account = manager.activeAccount;
        OfflineChanges * changes = account.changes;
        NSMutableArray * deleteIds = [NSMutableArray array];
        for (OCPuzzleDeletion * deletion in changes.puzzleDeletions) {
            [deleteIds addObject:[deletion identifier]];
        }
        ANAPICallPuzzleDelete * req =  [[ANAPICallPuzzleDelete alloc] initWithPuzzleIds:deleteIds];
        [self sendAPICall:req returnSelector:@selector(handleResponse:)];
        theDeleteIds = deleteIds;
    }
    return self;
}

- (void)handleResponse:(NSDictionary *)resp {
    ANDataManager * manager = [ANDataManager sharedDataManager];
    for (NSData * ident in theDeleteIds) {
        OCPuzzleDeletion * del = [manager findPuzzleDeletionForId:ident];
        if (del) {
            [manager.context deleteObject:del];
        }
    }
}

@end
