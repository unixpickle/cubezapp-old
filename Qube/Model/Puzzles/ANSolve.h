//
//  ANSolve.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANSession;

@interface ANSolve : NSManagedObject

@property (nonatomic, retain) NSString * scramble;
@property (nonatomic) NSTimeInterval startDate;
@property (nonatomic) int16_t status;
@property (nonatomic) double time;
@property (nonatomic) double inspectionTime;
@property (nonatomic, retain) ANSession *session;

@end
