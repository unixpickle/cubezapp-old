//
//  OCSessionDeletion.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineChanges;

@interface OCSessionDeletion : NSManagedObject

@property (nonatomic, retain) NSData * identifier;
@property (nonatomic, retain) OfflineChanges *changes;

@end
