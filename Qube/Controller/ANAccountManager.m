//
//  ANAccountManager.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountManager.h"

@interface ANAccountManager (Private)

- (void)handleLoginResponse:(NSDictionary *)dict;
- (void)generateOfflineChanges;

@end

@implementation ANAccountManager

+ (ANAccountManager *)sharedAccountManager {
    static ANAccountManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANAccountManager alloc] init];
    });
    return manager;
}

- (void)generateDefaultAccount {
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    NSManagedObjectContext * context = [ANDataManager sharedDataManager].context;
    // remove all puzzles
    for (ANPuzzle * puzzle in account.puzzles) {
        [context deleteObject:puzzle];
    }
    // remove all changes
    [context deleteObject:account.changes];
    account.changes = [NSEntityDescription insertNewObjectForEntityForName:@"OfflineChanges"
                                                    inManagedObjectContext:context];
    account.username = nil;
    account.passwordmd5 = nil;
}

- (void)logout {
    [[ANSyncManager sharedSyncManager] cancelSync];
    [loginCall cancel];
    
    [self.delegate accountManagerUserLoggedOut:self];
    
    [self generateDefaultAccount];
}

- (void)invalidateAuthentication {
    [ANDataManager sharedDataManager].activeAccount.passwordmd5 = nil;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
              keepingData:(BOOL)offlineData {
    [loginCall cancel];
    NSData * hash = [[password dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
    loginCall = [[ANAPIBaseCall alloc] initWithAPI:@"account.signin"
                                            params:@{@"username": username,
                                                     @"hash": hash}];
    [loginCall fetchResponse:^(NSError * error, NSDictionary * obj) {
        if (error) {
            [self.delegate accountManager:self loginFailed:error];
        } else {
            if (!offlineData) {
                [self generateDefaultAccount];
            }
            LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
            account.username = username;
            account.passwordmd5 = hash;
            [self handleLoginResponse:obj];
        }
    }];
}

#pragma mark - Status -

- (BOOL)isSignedOut {
    return [ANDataManager sharedDataManager].activeAccount.passwordmd5 == nil;
}

- (BOOL)isInvalidatedAuthentication {
    if ([self isSignedOut]) {
        return [ANDataManager sharedDataManager].activeAccount.username != nil;
    }
    return NO;
}

- (BOOL)shouldAllowKeepingData:(NSString *)username {
    if (![self isSignedOut]) return NO;
    if ([self isInvalidatedAuthentication]) {
        return [[ANDataManager sharedDataManager].activeAccount.username isEqualToString:username];
    }
    return [[ANDataManager sharedDataManager].activeAccount.puzzles count] != 0;
}

#pragma mark - Private -

- (void)handleLoginResponse:(NSDictionary *)dict {
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    [account decodeAccount:dict];
    [self.delegate accountManagerLoggedIn:self];
    
    [[ANSyncManager sharedSyncManager] startSyncing];
}

@end
