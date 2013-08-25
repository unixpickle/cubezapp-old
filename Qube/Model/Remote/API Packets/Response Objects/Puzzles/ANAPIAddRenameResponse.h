//
//  ANAPIAddResponseObj.h
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIConflict.h"
#import "ANDataManager+Search.h"

@interface ANAPIAddRenameResponse : NSObject {
    NSArray * conflicts;
    NSArray * successes;
}

@property (readonly) NSArray * conflicts;
@property (readonly) NSArray * successes;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
