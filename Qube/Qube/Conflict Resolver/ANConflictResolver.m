//
//  ANConflictResolver.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANConflictResolver.h"

@implementation ANConflictResolver

@synthesize delegate;

+ (ANConflictResolver *)sharedConflictResolver {
    static ANConflictResolver * resolver = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        resolver = [[ANConflictResolver alloc] init];
    });
    return resolver;
}

- (void)pushConflict:(ANConflict *)conflict {
    NSLog(@"no way of resolving conflicts yet");
}

- (void)cancelConflict:(ANConflict *)conflict {
    NSLog(@"no way of cancelling conflicts yet");
}

@end
