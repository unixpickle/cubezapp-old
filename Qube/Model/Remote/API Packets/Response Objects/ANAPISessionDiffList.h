//
//  ANAPISessionDiffList.h
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"

@interface ANAPISessionDiffList : NSObject {
    NSData * prefix;
    NSArray * deleteSessions;
    NSArray * addSessions;
}

@property (readonly) NSData * prefix;
@property (readonly) NSArray * deleteSessions;
@property (readonly) NSArray * addSessions;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
