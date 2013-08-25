//
//  LocalAccount.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANPuzzle, OfflineChanges;

@interface LocalAccount : NSManagedObject

@property (nonatomic, retain) NSData * passwordmd5;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSData * cubeScheme;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) OfflineChanges *changes;
@property (nonatomic, retain) NSOrderedSet *puzzles;
@end

@interface LocalAccount (CoreDataGeneratedAccessors)

- (void)insertObject:(ANPuzzle *)value inPuzzlesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPuzzlesAtIndex:(NSUInteger)idx;
- (void)insertPuzzles:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePuzzlesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPuzzlesAtIndex:(NSUInteger)idx withObject:(ANPuzzle *)value;
- (void)replacePuzzlesAtIndexes:(NSIndexSet *)indexes withPuzzles:(NSArray *)values;
- (void)addPuzzlesObject:(ANPuzzle *)value;
- (void)removePuzzlesObject:(ANPuzzle *)value;
- (void)addPuzzles:(NSOrderedSet *)values;
- (void)removePuzzles:(NSOrderedSet *)values;
@end
