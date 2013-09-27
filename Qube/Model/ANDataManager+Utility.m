//
//  ANDataManager+Utility.m
//  Qube
//
//  Created by Alex Nichol on 9/27/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Utility.h"

@implementation ANDataManager (Utility)

- (ANPuzzle *)createUnownedPuzzleObject {
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ANPuzzle"
                                               inManagedObjectContext:context];
    ANPuzzle * puzzle = (ANPuzzle *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    NSEntityDescription * additionDesc = [NSEntityDescription entityForName:@"OCPuzzleAddition"
                                                     inManagedObjectContext:context];
    OCPuzzleAddition * addition = (OCPuzzleAddition *)[[NSManagedObject alloc] initWithEntity:additionDesc
                                                               insertIntoManagedObjectContext:nil];
    puzzle.ocAddition = addition;
    addition.puzzle = puzzle;
    return puzzle;
}

- (void)addUnownedPuzzleObject:(ANPuzzle *)puzzle {
    [self.context insertObject:puzzle.ocAddition];
    [self.context insertObject:puzzle];
    [self.activeAccount.changes addPuzzleAdditionsObject:puzzle.ocAddition];
    [self.activeAccount addPuzzlesObject:puzzle];
}

@end
