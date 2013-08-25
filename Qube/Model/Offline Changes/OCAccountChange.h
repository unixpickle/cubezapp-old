//
//  OCAccountChange.h
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineChanges;

@interface OCAccountChange : NSManagedObject

@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSData * attributeValue;
@property (nonatomic, retain) OfflineChanges *changes;

@end
