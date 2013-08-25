//
//  ANAPISessionAddResponse.m
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPISessionAddResponse.h"

@implementation ANAPISessionAddResponse

@synthesize sessions;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        NSMutableArray * mSessions = [NSMutableArray array];
        for (NSData * anId in [dict objectForKey:@"ids"]) {
            ANSession * session = [[ANDataManager sharedDataManager] findSessionForId:anId];
            if (session) [mSessions addObject:session];
        }
        sessions = mSessions;
    }
    return self;
}

@end
