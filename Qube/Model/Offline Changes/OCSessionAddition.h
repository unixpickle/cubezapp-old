//
//  OCSessionAddition.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANSession, OfflineChanges;

@interface OCSessionAddition : NSManagedObject

@property (nonatomic, retain) OfflineChanges *changes;
@property (nonatomic, retain) ANSession *session;

@end
