//
//  ANSession.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANPuzzle, ANSolve, OCSessionAddition;

@interface ANSession : NSManagedObject

@property (nonatomic, retain) NSData * identifier;
@property (nonatomic, retain) OCSessionAddition *ocAddition;
@property (nonatomic, retain) ANPuzzle *puzzle;
@property (nonatomic, retain) NSOrderedSet *solves;
@end

@interface ANSession (CoreDataGeneratedAccessors)

- (void)insertObject:(ANSolve *)value inSolvesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSolvesAtIndex:(NSUInteger)idx;
- (void)insertSolves:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSolvesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSolvesAtIndex:(NSUInteger)idx withObject:(ANSolve *)value;
- (void)replaceSolvesAtIndexes:(NSIndexSet *)indexes withSolves:(NSArray *)values;
- (void)addSolvesObject:(ANSolve *)value;
- (void)removeSolvesObject:(ANSolve *)value;
- (void)addSolves:(NSOrderedSet *)values;
- (void)removeSolves:(NSOrderedSet *)values;
@end
