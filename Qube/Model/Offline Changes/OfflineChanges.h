//
//  OfflineChanges.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LocalAccount, OCPuzzleAddition, OCPuzzleDeletion, OCPuzzleSetting, OCSessionAddition, OCSessionDeletion;

@interface OfflineChanges : NSManagedObject

@property (nonatomic, retain) LocalAccount *localAccount;
@property (nonatomic, retain) NSOrderedSet *puzzleAdditions;
@property (nonatomic, retain) NSOrderedSet *puzzleDeletions;
@property (nonatomic, retain) NSOrderedSet *puzzleSettings;
@property (nonatomic, retain) NSOrderedSet *sessionAdditions;
@property (nonatomic, retain) NSOrderedSet *sessionDeletions;
@property (nonatomic, retain) NSManagedObject *accountChanges;
@end

@interface OfflineChanges (CoreDataGeneratedAccessors)

- (void)insertObject:(OCPuzzleAddition *)value inPuzzleAdditionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPuzzleAdditionsAtIndex:(NSUInteger)idx;
- (void)insertPuzzleAdditions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePuzzleAdditionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPuzzleAdditionsAtIndex:(NSUInteger)idx withObject:(OCPuzzleAddition *)value;
- (void)replacePuzzleAdditionsAtIndexes:(NSIndexSet *)indexes withPuzzleAdditions:(NSArray *)values;
- (void)addPuzzleAdditionsObject:(OCPuzzleAddition *)value;
- (void)removePuzzleAdditionsObject:(OCPuzzleAddition *)value;
- (void)addPuzzleAdditions:(NSOrderedSet *)values;
- (void)removePuzzleAdditions:(NSOrderedSet *)values;
- (void)insertObject:(OCPuzzleDeletion *)value inPuzzleDeletionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPuzzleDeletionsAtIndex:(NSUInteger)idx;
- (void)insertPuzzleDeletions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePuzzleDeletionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPuzzleDeletionsAtIndex:(NSUInteger)idx withObject:(OCPuzzleDeletion *)value;
- (void)replacePuzzleDeletionsAtIndexes:(NSIndexSet *)indexes withPuzzleDeletions:(NSArray *)values;
- (void)addPuzzleDeletionsObject:(OCPuzzleDeletion *)value;
- (void)removePuzzleDeletionsObject:(OCPuzzleDeletion *)value;
- (void)addPuzzleDeletions:(NSOrderedSet *)values;
- (void)removePuzzleDeletions:(NSOrderedSet *)values;
- (void)insertObject:(OCPuzzleSetting *)value inPuzzleSettingsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPuzzleSettingsAtIndex:(NSUInteger)idx;
- (void)insertPuzzleSettings:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePuzzleSettingsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPuzzleSettingsAtIndex:(NSUInteger)idx withObject:(OCPuzzleSetting *)value;
- (void)replacePuzzleSettingsAtIndexes:(NSIndexSet *)indexes withPuzzleSettings:(NSArray *)values;
- (void)addPuzzleSettingsObject:(OCPuzzleSetting *)value;
- (void)removePuzzleSettingsObject:(OCPuzzleSetting *)value;
- (void)addPuzzleSettings:(NSOrderedSet *)values;
- (void)removePuzzleSettings:(NSOrderedSet *)values;
- (void)insertObject:(OCSessionAddition *)value inSessionAdditionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSessionAdditionsAtIndex:(NSUInteger)idx;
- (void)insertSessionAdditions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSessionAdditionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSessionAdditionsAtIndex:(NSUInteger)idx withObject:(OCSessionAddition *)value;
- (void)replaceSessionAdditionsAtIndexes:(NSIndexSet *)indexes withSessionAdditions:(NSArray *)values;
- (void)addSessionAdditionsObject:(OCSessionAddition *)value;
- (void)removeSessionAdditionsObject:(OCSessionAddition *)value;
- (void)addSessionAdditions:(NSOrderedSet *)values;
- (void)removeSessionAdditions:(NSOrderedSet *)values;
- (void)insertObject:(OCSessionDeletion *)value inSessionDeletionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSessionDeletionsAtIndex:(NSUInteger)idx;
- (void)insertSessionDeletions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSessionDeletionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSessionDeletionsAtIndex:(NSUInteger)idx withObject:(OCSessionDeletion *)value;
- (void)replaceSessionDeletionsAtIndexes:(NSIndexSet *)indexes withSessionDeletions:(NSArray *)values;
- (void)addSessionDeletionsObject:(OCSessionDeletion *)value;
- (void)removeSessionDeletionsObject:(OCSessionDeletion *)value;
- (void)addSessionDeletions:(NSOrderedSet *)values;
- (void)removeSessionDeletions:(NSOrderedSet *)values;
@end
