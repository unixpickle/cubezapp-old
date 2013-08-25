//
//  ANAccountManager.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDataManager.h"
#import "ANAPIBaseCall.h"
#import "NSData+MD5.h"
#import "ANSyncManager.h"

@class ANAccountManager;

@protocol ANAccountManagerDelegate <NSObject>

- (void)accountManagerLoggedIn:(ANAccountManager *)manager;
- (void)accountManager:(ANAccountManager *)manager loginFailed:(NSError *)error;

@end

@interface ANAccountManager : NSObject {
    ANAPIBaseCall * loginCall;
}

@property (nonatomic, weak) id<ANAccountManagerDelegate> delegate;

+ (ANAccountManager *)sharedAccountManager;

- (void)generateDefaultAccount;
- (void)logout;
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
              keepingData:(BOOL)offlineData;

@end
