//
//  ANAccountSyncer.h
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGeneralSyncer.h"

@class ANAccountSyncer;

@protocol ANAccountSyncerDelegate <ANGeneralSyncerDelegate>

- (void)accountSyncer:(ANAccountSyncer *)syncer updatedAccount:(LocalAccount *)account;

@end

@interface ANAccountSyncer : ANGeneralSyncer {
    __weak id<ANAccountSyncerDelegate> delegate;
}

@property (nonatomic, weak) id<ANAccountSyncerDelegate> delegate;

@end
