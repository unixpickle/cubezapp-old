//
//  ANAPIConflictObj.m
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIConflict.h"

@implementation ANAPIConflict

@synthesize localPuzzle=localPuzzle;
@synthesize remotePuzzle=remotePuzzle;

- (id)initWithConflictInfo:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        NSDictionary * remotePuzzleDict = [dictionary objectForKey:@"remotePuzzle"];
        NSData * localId = [dictionary objectForKey:@"localId"];
        remotePuzzle = [[ANAPIPuzzle alloc] initWithDictionary:remotePuzzleDict];
        localPuzzle = [[ANDataManager sharedDataManager] findPuzzleForId:localId];
    }
    return self;
}

@end
