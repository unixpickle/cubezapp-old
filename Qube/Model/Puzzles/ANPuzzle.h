//
//  ANPuzzle.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANSession, LocalAccount, OCPuzzleAddition, OCPuzzleSetting;

@interface ANPuzzle : NSManagedObject

@property (nonatomic) BOOL hidden;
@property (nonatomic, retain) NSData * iconColor;
@property (nonatomic, retain) NSData * identifier;
@property (nonatomic, retain) NSData * image;
@property (nonatomic) double inspectionTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL scramble;
@property (nonatomic) int16_t scrambleLength;
@property (nonatomic) BOOL showScramble;
@property (nonatomic) BOOL showStats;
@property (nonatomic) int16_t type;
@property (nonatomic, retain) LocalAccount *account;
@property (nonatomic, retain) OCPuzzleAddition *ocAddition;
@property (nonatomic, retain) NSSet *ocSettings;
@property (nonatomic, retain) NSOrderedSet *sessions;
@end

@interface ANPuzzle (CoreDataGeneratedAccessors)

- (void)addOcSettingsObject:(OCPuzzleSetting *)value;
- (void)removeOcSettingsObject:(OCPuzzleSetting *)value;
- (void)addOcSettings:(NSSet *)values;
- (void)removeOcSettings:(NSSet *)values;

- (void)insertObject:(ANSession *)value inSessionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSessionsAtIndex:(NSUInteger)idx;
- (void)insertSessions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSessionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSessionsAtIndex:(NSUInteger)idx withObject:(ANSession *)value;
- (void)replaceSessionsAtIndexes:(NSIndexSet *)indexes withSessions:(NSArray *)values;
- (void)addSessionsObject:(ANSession *)value;
- (void)removeSessionsObject:(ANSession *)value;
- (void)addSessions:(NSOrderedSet *)values;
- (void)removeSessions:(NSOrderedSet *)values;
@end
