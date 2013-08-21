//
//  ANAPIDeleteResponse.m
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIDeleteResponse.h"

@implementation ANAPIDeleteResponse

@synthesize requests;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        NSMutableArray * mRequests = [NSMutableArray array];
        for (NSData * puzzleId in [dict objectForKey:@"ids"]) {
            OCPuzzleDeletion * deletion = [[ANDataManager sharedDataManager] findPuzzleDeletionForId:puzzleId];
            if (deletion) [mRequests addObject:deletion];
        }
        requests = [mRequests copy];
    }
    return self;
}

@end
