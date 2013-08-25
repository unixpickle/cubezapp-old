//
//  OCPuzzleAddition.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANPuzzle, OfflineChanges;

@interface OCPuzzleAddition : NSManagedObject

@property (nonatomic, retain) OfflineChanges *changes;
@property (nonatomic, retain) ANPuzzle *puzzle;

@end
