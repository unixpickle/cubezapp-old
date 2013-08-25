//
//  ANAPISessionDiffList.m
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPISessionDiffList.h"

@implementation ANAPISessionDiffList

@synthesize prefix;
@synthesize addSessions;
@synthesize deleteSessions;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        prefix = [dict objectForKey:@"idPrefix"];
        NSMutableArray * mSessions = [NSMutableArray array];
        for (NSData * anId in [dict objectForKey:@"remove"]) {
            ANSession * session = [[ANDataManager sharedDataManager] findSessionForId:anId];
            if (session) [mSessions addObject:session];
        }
        deleteSessions = [mSessions copy];
        addSessions = [dict objectForKey:@"add"];
    }
    return self;
}

@end
