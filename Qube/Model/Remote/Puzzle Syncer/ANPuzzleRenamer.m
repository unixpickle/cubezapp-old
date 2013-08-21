//
//  ANPuzzleRenamer.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleRenamer.h"

@interface ANPuzzleRenamer (Private)

- (OCPuzzleSetting *)renameSettingForPuzzle:(ANPuzzle *)puzzle;
- (void)handleRenameResponse:(NSDictionary *)response;
- (void)handleDeleteResponse:(NSDictionary *)response;
- (void)handleConflictReplaceKeepLocal:(ANRenameCollisionConflict *)conflict;
- (void)handleConflictReplaceKeepRemote:(ANRenameCollisionConflict *)conflict;
- (void)handleConflictRename:(ANRenameCollisionConflict *)conflict locally:(BOOL)flag;

@end

@implementation ANPuzzleRenamer

+ (Class)nameConflictClass {
    return [ANRenameCollisionConflict class];
}

- (id)initWithDataManager:(ANDataManager *)aManager delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aManager delegate:aDel])) {
        NSMutableArray * reqs = [[NSMutableArray alloc] init];
        for (OCPuzzleSetting * setting in manager.activeAccount.changes.puzzleSettings) {
            if ([setting.attribute isEqualToString:kANPuzzleAttributeName]) {
                [reqs addObject:setting];
            }
        }
        ANAPIRenameRequest * call = [[ANAPIRenameRequest alloc] initWithPuzzleSettingChanges:reqs];
        [self sendAPICall:call returnSelector:@selector(handleRenameResponse:)];
    }
    return self;
}

#pragma mark - Responses -

- (void)handleRenameResponse:(NSDictionary *)responseData {
    ANAPIAddRenameResponse * response = [[ANAPIAddRenameResponse alloc] initWithDictionary:responseData];
    for (ANPuzzle * puzzle in response.successes) {
        OCPuzzleSetting * theSetting = [self renameSettingForPuzzle:puzzle];
        if (!theSetting) continue;
        [manager.context deleteObject:theSetting];
    }
    for (ANAPIConflict * conflict in response.conflicts) {
        [self raiseConflict:conflict];
    }
}

- (void)handleDeleteResponse:(NSDictionary *)response {
    for (NSData * deleteId in [response objectForKey:@"ids"]) {
        ANPuzzle * puzzle = [manager findPuzzleForId:deleteId];
        if (!puzzle) continue;
        [delegate puzzleSyncer:self deletedPuzzle:puzzle];
        [manager.context deleteObject:puzzle];
    }
}

#pragma mark - Conflicts -

- (void)handleConflictReplaceKeepLocal:(ANRenameCollisionConflict *)conflict {
    ANAPIDeleteRename * delRen = [[ANAPIDeleteRename alloc] initWithRemoteId:conflict.remotePuzzle.identifier
                                                                    renameId:conflict.localPuzzle.identifier
                                                                        name:conflict.localPuzzle.name];
    [self sendAPICall:delRen returnSelector:@selector(handleRenameResponse:)];
}

- (void)handleConflictReplaceKeepRemote:(ANRenameCollisionConflict *)conflict {
    ANAPIDeleteRequest * delete = [[ANAPIDeleteRequest alloc] initWithPuzzleIds:@[conflict.localPuzzle.identifier]];
    [self sendAPICall:delete returnSelector:@selector(handleDeleteResponse:)];
}

- (void)handleConflictRename:(ANRenameCollisionConflict *)conflict locally:(BOOL)flag {
    if (flag) {
        // rename the local version and then resend
        conflict.localPuzzle.name = conflict.returnedInput;
        [delegate puzzleSyncer:self updatedPuzzle:conflict.localPuzzle];
        
        OCPuzzleSetting * renameReq = [self renameSettingForPuzzle:conflict.localPuzzle];
        if (!renameReq) return;
        renameReq.attribute = conflict.returnedInput;
        
        ANAPIRenameRequest * req = [[ANAPIRenameRequest alloc] initWithPuzzleSettingChanges:@[renameReq]];
        [self sendAPICall:req returnSelector:@selector(handleRenameResponse:)];
    } else {
        // rename the remote version and then this version
        ANAPIRenameRequest * req = [[ANAPIRenameRequest alloc] initWithPuzzleIds:@[conflict.remotePuzzle.identifier,
                                                                                   conflict.localPuzzle.identifier]
                                                                           names:@[conflict.returnedInput,
                                                                                   conflict.localPuzzle.name]];
        [self sendAPICall:req returnSelector:@selector(handleRenameResponse:)];
    }
}

#pragma mark - Superclass Calls -

- (void)handleConflict:(ANConflict *)conflict resolved:(NSInteger)option {
    NSAssert([conflict class] == [ANRenameCollisionConflict class], @"Incorrect conflict class.");
    [conflicts removeObject:conflict];
    ANRenameCollisionConflict * nameCol = (ANRenameCollisionConflict *)conflict;
    ANNameCollisionConflictResolution resolution = [nameCol resolutionForIndex:(int)option];
    if (resolution == ANNameCollisionConflictResolutionKeepLocal) {
        [self handleConflictReplaceKeepLocal:nameCol];
    } else if (resolution == ANNameCollisionConflictResolutionKeepRemote) {
        [self handleConflictReplaceKeepRemote:nameCol];
    } else if (resolution == ANNameCollisionConflictResolutionRenameLocal ||
               resolution == ANNameCollisionConflictResolutionRenameRemote) {
        BOOL locally = resolution == ANNameCollisionConflictResolutionRenameLocal;
        [self handleConflictRename:nameCol locally:locally];
    } else {
        NSLog(@"invalid resolution");
        abort();
    }
}

#pragma mark - Utility -

- (OCPuzzleSetting *)renameSettingForPuzzle:(ANPuzzle *)puzzle {
    for (OCPuzzleSetting * setting in puzzle.ocSettings) {
        if ([setting.attribute isEqualToString:kANPuzzleAttributeName]) {
            return setting;
        }
    }
    return nil;
}

@end
