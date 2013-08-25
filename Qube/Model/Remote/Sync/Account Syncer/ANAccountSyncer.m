//
//  ANAccountSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountSyncer.h"

@implementation ANAccountSyncer

@synthesize delegate;

- (id)initWithDelegate:(id<ANAccountSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        delegate = aDel;
    }
    return self;
}

@end
