//
//  ANDataManager+Search.m
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"

@implementation ANDataManager (Search)

+ (BOOL)puzzleName:(NSString *)name isEqual:(NSString *)otherName {
    return ([name caseInsensitiveCompare:otherName] == NSOrderedSame);
}

- (id)findManagedObject:(NSString *)name withIdentifier:(NSData *)identifier {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:name]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]];
    NSArray * list = [context executeFetchRequest:request error:nil];
    NSAssert([list count] < 2, @"Reused identifier is not allowed!");
    return [list lastObject];
}

#pragma mark - Accounts -

- (OCAccountChange *)findAccountChangeForAttribute:(NSString *)attribute {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:@"OCAccountChange"]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"attribute=%@", attribute]];
    NSArray * list = [context executeFetchRequest:request error:nil];
    NSAssert([list count] < 2, @"Too many account changes for one attribute!");
    return [list lastObject];
}

#pragma mark - Puzzles -

- (ANPuzzle *)findPuzzleForId:(NSData *)identifier {
    return [self findManagedObject:@"ANPuzzle" withIdentifier:identifier];
}

- (ANPuzzle *)findPuzzleForName:(NSString *)name {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:@"ANPuzzle"]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name LIKE[c] %@", name]];
    NSArray * puzzleList = [context executeFetchRequest:request error:nil];
    NSAssert([puzzleList count] < 2, @"Reused puzzle ID is not allowed!");
    return [puzzleList lastObject];
}

- (OCPuzzleDeletion *)findPuzzleDeletionForId:(NSData *)identifier {
    return [self findManagedObject:@"OCPuzzleDeletion" withIdentifier:identifier];
}

#pragma mark - Sessions -

- (ANSession *)findSessionForId:(NSData *)identifier {
    return [self findManagedObject:@"ANSession" withIdentifier:identifier];
}

- (OCSessionDeletion *)findSessionDeletionForId:(NSData *)identifier {
    return [self findManagedObject:@"OCSessionDeletion" withIdentifier:identifier];
}

#pragma mark - Images -

- (NSArray *)findPuzzlesWithImageHash:(NSData *)hash {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:@"ANPuzzle"]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"image == %@", hash]];
    return [context executeFetchRequest:request error:nil];
}

@end
