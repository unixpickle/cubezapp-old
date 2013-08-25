//
//  OfflineChanges.h
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LocalAccount, OCAccountChange, OCPuzzleAddition, OCPuzzleDeletion, OCPuzzleSetting, OCSessionAddition, OCSessionDeletion;

@interface OfflineChanges : NSManagedObject

@property (nonatomic, retain) NSSet *accountChanges;
@property (nonatomic, retain) LocalAccount *localAccount;
@property (nonatomic, retain) NSSet *puzzleAdditions;
@property (nonatomic, retain) NSSet *puzzleDeletions;
@property (nonatomic, retain) NSSet *puzzleSettings;
@property (nonatomic, retain) NSSet *sessionAdditions;
@property (nonatomic, retain) NSSet *sessionDeletions;
@end

@interface OfflineChanges (CoreDataGeneratedAccessors)

- (void)addAccountChangesObject:(OCAccountChange *)value;
- (void)removeAccountChangesObject:(OCAccountChange *)value;
- (void)addAccountChanges:(NSSet *)values;
- (void)removeAccountChanges:(NSSet *)values;

- (void)addPuzzleAdditionsObject:(OCPuzzleAddition *)value;
- (void)removePuzzleAdditionsObject:(OCPuzzleAddition *)value;
- (void)addPuzzleAdditions:(NSSet *)values;
- (void)removePuzzleAdditions:(NSSet *)values;

- (void)addPuzzleDeletionsObject:(OCPuzzleDeletion *)value;
- (void)removePuzzleDeletionsObject:(OCPuzzleDeletion *)value;
- (void)addPuzzleDeletions:(NSSet *)values;
- (void)removePuzzleDeletions:(NSSet *)values;

- (void)addPuzzleSettingsObject:(OCPuzzleSetting *)value;
- (void)removePuzzleSettingsObject:(OCPuzzleSetting *)value;
- (void)addPuzzleSettings:(NSSet *)values;
- (void)removePuzzleSettings:(NSSet *)values;

- (void)addSessionAdditionsObject:(OCSessionAddition *)value;
- (void)removeSessionAdditionsObject:(OCSessionAddition *)value;
- (void)addSessionAdditions:(NSSet *)values;
- (void)removeSessionAdditions:(NSSet *)values;

- (void)addSessionDeletionsObject:(OCSessionDeletion *)value;
- (void)removeSessionDeletionsObject:(OCSessionDeletion *)value;
- (void)addSessionDeletions:(NSSet *)values;
- (void)removeSessionDeletions:(NSSet *)values;

@end
