//
//  ANAPISetResponse.m
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIPuzzleSetResponse.h"

@implementation ANAPIPuzzleSetResponse

@synthesize setRequests;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        NSMutableArray * mRequests = [NSMutableArray array];
        
        // Only use the set requests which have the same set *value* as
        // well as puzzle and attribute. This accounts for the user
        // instantaneously changing a setting on something while
        // the server applies an old update with the same attribute
        // but a different value.
        for (NSDictionary * reqObj in [dictionary objectForKey:@"sets"]) {
            NSData * theId = [reqObj objectForKey:@"id"];
            NSString * attr = [reqObj objectForKey:@"attribute"];
            NSData * value = [reqObj objectForKey:@"value"];
            ANPuzzle * puzzle = [[ANDataManager sharedDataManager] findPuzzleForId:theId];
            if (!puzzle) continue;
            for (OCPuzzleSetting * setting in puzzle.ocSettings) {
                if ([setting.attribute isEqualToString:attr]) {
                    if ([setting.attributeValue isEqualToData:value]) {
                        [mRequests addObject:setting];
                        break;
                    }
                }
            }
        }
        
        setRequests = [mRequests copy];
    }
    return self;
}

@end
