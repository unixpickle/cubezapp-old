//
//  ANConflictResolver.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANRenameCollisionConflict.h"

@class ANConflictResolver;

@protocol ANConflictResolverDelegate

- (void)conflictResolver:(id)sender resolved:(ANConflict *)conflict withChoice:(NSInteger)choice;

@end

@interface ANConflictResolver : NSObject

@property (nonatomic, weak) id<ANConflictResolverDelegate> delegate;

+ (ANConflictResolver *)sharedConflictResolver;

- (void)pushConflict:(ANConflict *)conflict;
- (void)cancelConflict:(ANConflict *)conflict;

@end
