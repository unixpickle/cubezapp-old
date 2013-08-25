//
//  ANPuzzleAdder.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleAdder.h"

@interface ANPuzzleAdder (Private)

- (void)addRequestResponse:(NSDictionary *)response;

- (void)handleConflictReplaceKeepLocal:(ANNameCollisionConflict *)conflict;
- (void)handleConflictReplaceKeepRemote:(ANNameCollisionConflict *)conflict;
- (void)handleConflictMerge:(ANNameCollisionConflict *)conflict remoteSettings:(BOOL)flag;
- (void)handleConflictRename:(ANNameCollisionConflict *)conflict locally:(BOOL)flag;

@end

@implementation ANPuzzleAdder

+ (Class)nameConflictClass {
    return [ANNameCollisionConflict class];
}

- (id)initWithDelegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANDataManager * manager = [ANDataManager sharedDataManager];
        NSArray * added = [manager.activeAccount.changes.puzzleAdditions allObjects];
        ANAPICallPuzzleAdd * addReq = [[ANAPICallPuzzleAdd alloc] initWithPuzzleAdditions:added];
        [self sendAPICall:addReq returnSelector:@selector(addRequestResponse:)];
    }
    return self;
}

#pragma mark - Response Handler -

- (void)addRequestResponse:(NSDictionary *)response {
    ANAPIAddRenameResponse * obj = [[ANAPIAddRenameResponse alloc] initWithDictionary:response];
    for (ANAPIConflict * conflict in obj.conflicts) {
        if (!conflict.localPuzzle) continue;
        [self raiseConflict:conflict];
    }
    
    for (ANPuzzle * puzzle in obj.successes) {
        if (puzzle.ocAddition) {
            ANDataManager * manager = [ANDataManager sharedDataManager];
            [manager.context deleteObject:puzzle.ocAddition];
        }
    }
}

#pragma mark - Conflict Resolution -

- (void)handleConflictReplaceKeepLocal:(ANNameCollisionConflict *)conflict {
    // here we tell the server to replace the puzzle with our own.
    // at this point the server deletes all sessions for the puzzle as well
    ANAPICallPuzzleReplace * replace = [[ANAPICallPuzzleReplace alloc] initWithRemoteId:conflict.remotePuzzle.identifier
                                                                           puzzle:conflict.localPuzzle];
    [self sendAPICall:replace returnSelector:@selector(addRequestResponse:)];
}

- (void)handleConflictReplaceKeepRemote:(ANNameCollisionConflict *)conflict {
    // the remote puzzle will be synced later in the process
    [delegate puzzleSyncer:self deletedPuzzle:conflict.localPuzzle];
    ANDataManager * manager = [ANDataManager sharedDataManager];
    [manager.context deleteObject:conflict.localPuzzle];
}

- (void)handleConflictMerge:(ANNameCollisionConflict *)conflict remoteSettings:(BOOL)flag {
    // assume the server's puzzle ID and (depending on the situation)
    // potentially adopt the server's settings as well
    conflict.localPuzzle.identifier = [conflict.remotePuzzle identifier];
    if (flag) {
        // copy the remote settings
        [conflict.localPuzzle decodePuzzle:conflict.remotePuzzle.dictionary
                                    withId:NO];
    }
    ANDataManager * manager = [ANDataManager sharedDataManager];
    [manager.context deleteObject:conflict.localPuzzle.ocAddition];
}

- (void)handleConflictRename:(ANNameCollisionConflict *)conflict locally:(BOOL)flag {
    // rename the local puzzle and re-add or rename
    // the remote puzzle and re-add using a `renameThenAdd` request
    if (flag) {
        conflict.localPuzzle.name = conflict.returnedInput;
        ANAPICallPuzzleAdd * addReq = [[ANAPICallPuzzleAdd alloc] initWithPuzzles:@[conflict.localPuzzle]];
        [self sendAPICall:addReq returnSelector:@selector(addRequestResponse:)];
        [delegate puzzleSyncer:self updatedPuzzle:conflict.localPuzzle];
    } else {
        // We handle the response just like a normal ANAPIAddRenameResponse even
        // though the additional error could occur that the remote name is taken.
        // In this case, the conflict will simply appear to be raised again, prompting
        // the user to pick a different name.
        ANAPICallPuzzleRenameAdd * call = [[ANAPICallPuzzleRenameAdd alloc] initWithRemoteId:conflict.remotePuzzle.identifier
                                                                    name:conflict.returnedInput
                                                                  puzzle:conflict.localPuzzle];
        [self sendAPICall:call returnSelector:@selector(addRequestResponse:)];
    }
}

#pragma mark - Superclass Calls -

- (void)handleConflict:(ANConflict *)conflict resolved:(NSInteger)choice {
    NSAssert([conflict class] == [ANNameCollisionConflict class], @"Incorrect conflict class.");
    [conflicts removeObject:conflict];
    ANNameCollisionConflict * nameCol = (ANNameCollisionConflict *)conflict;
    ANNameCollisionConflictResolution resolution = [nameCol resolutionForIndex:(int)choice];
    if (resolution == ANNameCollisionConflictResolutionKeepLocal) {
        [self handleConflictReplaceKeepLocal:nameCol];
    } else if (resolution == ANNameCollisionConflictResolutionKeepRemote) {
        [self handleConflictReplaceKeepRemote:nameCol];
    } else if (resolution == ANNameCollisionConflictResolutionMergeLocalSettings ||
               resolution == ANNameCollisionConflictResolutionMergeRemoteSettings) {
        BOOL remoteFlag = resolution == ANNameCollisionConflictResolutionMergeRemoteSettings;
        [self handleConflictMerge:nameCol remoteSettings:remoteFlag];
    } else if (resolution == ANNameCollisionConflictResolutionRenameLocal ||
               resolution == ANNameCollisionConflictResolutionRenameRemote) {
        BOOL locally = resolution == ANNameCollisionConflictResolutionRenameLocal;
        [self handleConflictRename:nameCol locally:locally];
    }
}

@end
