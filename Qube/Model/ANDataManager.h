//
//  ANDataManager.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "LocalAccount.h"
#import "ANPuzzle.h"
#import "ANSession.h"
#import "ANSolve.h"

#import "OCPuzzleAddition.h"
#import "OCPuzzleDeletion.h"
#import "OCPuzzleSetting.h"
#import "OCSessionAddition.h"
#import "OCSessionDeletion.h"
#import "OCAccountChange.h"
#import "OfflineChanges.h"

@interface ANDataManager : NSObject {
    NSManagedObjectContext * context;
    NSManagedObjectModel * model;
    LocalAccount * activeAccount;
}

@property (readonly) NSManagedObjectContext * context;

+ (ANDataManager *)sharedDataManager;

- (LocalAccount *)activeAccount;

- (ANPuzzle *)createPuzzleObject;
- (ANSession *)createSessionObject;
- (ANSolve *)createSolveObject;

@end
