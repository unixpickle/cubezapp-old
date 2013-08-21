//
//  ANPuzzleSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleSyncer.h"

@interface ANPuzzleSyncer (Private)

- (void)potentialCleanupSequence;

@end

@implementation ANPuzzleSyncer

@synthesize conflicts;
@synthesize delegate;

+ (Class)nameConflictClass {
    return Nil;
}

- (id)initWithDataManager:(ANDataManager *)aManager delegate:(id<ANPuzzleSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aManager delegate:aDel])) {
        delegate = aDel;
        conflicts = [NSMutableArray array];
        [ANConflictResolver sharedConflictResolver].delegate = self;
    }
    return self;
}

#pragma mark - Internal Operations -

- (void)raiseConflict:(ANAPIConflict *)conflict {
    ANNameCollisionConflict * collision = [[self.class.nameConflictClass alloc] init];
    collision.remotePuzzle = conflict.remotePuzzle;
    collision.localPuzzle = conflict.localPuzzle;
    [conflicts addObject:collision];
    [[ANConflictResolver sharedConflictResolver] pushConflict:collision];
}

#pragma mark - Conflict Delegate -

- (void)conflictResolver:(id)sender resolved:(ANConflict *)conflict withChoice:(NSInteger)choice {
    [conflicts removeObject:conflict];
    [self handleConflict:conflict resolved:choice];
    if ([self isCompleted]) {
        [delegate generalSyncerCompleted:self];
    }
}

#pragma mark - External Operations -

- (void)cancel {
    [super cancel];
    for (ANConflict * conflict in conflicts) {
        [[ANConflictResolver sharedConflictResolver] cancelConflict:conflict];
    }
}

#pragma mark - Subclass Calls -

- (void)handleConflict:(ANConflict *)conflict resolved:(NSInteger)option {
    [self doesNotRecognizeSelector:@selector(handleConflict:resolved:)];
}

- (BOOL)isCompleted {
    return [super isCompleted] && [conflicts count] == 0;
}

@end
