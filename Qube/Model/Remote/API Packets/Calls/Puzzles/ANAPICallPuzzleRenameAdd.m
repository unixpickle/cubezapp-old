//
//  ANAPIRenameAdd.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICallPuzzleRenameAdd.h"

@implementation ANAPICallPuzzleRenameAdd

- (id)initWithRemoteId:(NSData *)remoteId name:(NSString *)name
                puzzle:(ANPuzzle *)puzzle {
    NSDictionary * renThenAdd = @{@"remoteId": remoteId,
                                  @"name": name,
                                  @"puzzle": [puzzle encodePuzzle]};
    if ((self = [super initWithAPI:@"puzzles.renameThenAdd" params:renThenAdd])) {
    }
    return self;
}

@end
