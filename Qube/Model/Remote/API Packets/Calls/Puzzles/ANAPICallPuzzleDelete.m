//
//  ANAPIDeleteRequest.m
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallPuzzleDelete.h"

@implementation ANAPICallPuzzleDelete

- (id)initWithPuzzleIds:(NSArray *)identifiers {
    self = [super initWithAPI:@"puzzles.delete"
                       params:@{@"ids": identifiers}];
    return self;
}

@end
