//
//  ANPuzzleSyncer.h
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGeneralSyncer.h"
#import "ANAPICall.h"
#import "ANConflictResolver.h"
#import "ANAPIConflict.h"

@class AnpuzzleSyncer;

// note: delegate methods must be called from subclass
@protocol ANPuzzleSyncerDelegate <ANGeneralSyncerDelegate>

- (void)puzzleSyncer:(id)syncer updatedPuzzle:(ANPuzzle *)puzzle;
- (void)puzzleSyncer:(id)syncer addedPuzzle:(ANPuzzle *)puzzle;
- (void)puzzleSyncer:(id)syncer deletedPuzzle:(ANPuzzle *)puzzle;

@end

/**
 * This is a base class used for both ANPuzzleAdder and ANPuzzleRenamer.
 * These puzzle syncers need support for name conflict management and error
 * handling. ANPuzzleSyncer provides an easy interface for these purposes.
 */
@interface ANPuzzleSyncer : ANGeneralSyncer <ANConflictResolverDelegate> {
    NSMutableArray * conflicts;
    __weak id<ANPuzzleSyncerDelegate> delegate;
}

@property (readonly) NSMutableArray * conflicts;
@property (nonatomic, weak) id<ANPuzzleSyncerDelegate> delegate;

- (id)initWithDataManager:(ANDataManager *)manager delegate:(id<ANPuzzleSyncerDelegate>)aDel;

+ (Class)nameConflictClass;

- (void)raiseConflict:(ANAPIConflict *)conflict;
- (void)cancel;

- (void)handleConflict:(ANConflict *)conflict resolved:(NSInteger)option;

@end
