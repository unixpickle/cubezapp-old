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

- (ANSession *)findSessionForId:(NSData *)identifier {
    return [self findManagedObject:@"ANSession" withIdentifier:identifier];
}

@end
