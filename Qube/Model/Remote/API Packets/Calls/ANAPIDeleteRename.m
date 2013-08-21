//
//  ANAPIDeleteRename.m
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIDeleteRename.h"

@implementation ANAPIDeleteRename

- (id)initWithRemoteId:(NSData *)remoteId renameId:(NSData *)localId
                  name:(NSString *)name {
    NSDictionary * dictionary = @{@"deleteId": remoteId,
                                  @"rename": @{@"id": localId,
                                               @"name": name}};
    self = [super initWithAPI:@"puzzles.deleteThenRename" params:dictionary];
    return self;
}

@end
