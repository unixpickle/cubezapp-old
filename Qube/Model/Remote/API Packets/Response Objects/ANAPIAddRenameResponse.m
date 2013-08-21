//
//  ANAPIAddResponseObj.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIAddRenameResponse.h"

@implementation ANAPIAddRenameResponse

@synthesize conflicts;
@synthesize successes;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        NSMutableArray * mConflicts = [NSMutableArray array];
        for (NSDictionary * conflict in [dictionary objectForKey:@"nameConflicts"]) {
            ANAPIConflict * conflictObj = [[ANAPIConflict alloc] initWithConflictInfo:conflict];
            [mConflicts addObject:conflictObj];
        }
        conflicts = [mConflicts copy];
        
        NSMutableArray * mSuccesses = [NSMutableArray array];
        for (NSData * success in [dictionary objectForKey:@"successes"]) {
            ANPuzzle * puzzle = [[ANDataManager sharedDataManager] findPuzzleForId:success];
            if (puzzle) [mSuccesses addObject:puzzle];
        }
        successes = [mSuccesses copy];
    }
    return self;
}

@end
