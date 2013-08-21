//
//  ANSessionSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSessionSyncer.h"

@implementation ANSessionSyncer

@synthesize delegate;

- (id)initWithDataManager:(ANDataManager *)aMan delegate:(id<ANSessionSyncerDelegate>)aDel {
    if ((self = [super initWithDataManager:aMan delegate:aDel])) {
        delegate = aDel;
    }
    return self;
}

@end
