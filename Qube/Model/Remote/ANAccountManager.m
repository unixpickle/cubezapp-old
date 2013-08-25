//
//  ANAccountManager.m
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountManager.h"

@interface ANAccountManager (Private)

- (void)observerNotifyError:(NSError *)error;
- (void)observerLoggedIn;
- (void)handleLoginResponse:(NSDictionary *)dict;

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

- (id)init {
    if ((self = [super init])) {
        observers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObserver:(id<ANAccountManagerObserver>)observer {
    [observers addObject:observer];
}

- (void)removeObserver:(id<ANAccountManagerObserver>)observer {
    [observers removeObject:observer];
}

- (void)generateDefaultAccount {
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    NSManagedObjectContext * context = [ANDataManager sharedDataManager].context;
    if (!account) {
        account = [NSEntityDescription insertNewObjectForEntityForName:@"LocalAccount"
                                                inManagedObjectContext:context];
    } else {
        // remove all puzzles
        for (ANPuzzle * puzzle in account.puzzles) {
            [context deleteObject:puzzle];
        }
    }
    account.username = nil;
    account.passwordmd5 = nil;
}

- (void)logout {
    [[ANSyncManager sharedSyncManager] cancelSync];
    [loginCall cancel];
    [self generateDefaultAccount];
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
            [self observerNotifyError:error];
        } else {
            if (![[obj objectForKey:@"status"] boolValue]) {
                NSError * error = [NSError errorWithDomain:@"ANAccountManager"
                                                      code:1
                                                  userInfo:@{NSLocalizedDescriptionKey: @"Login incorrect"}];
                [self observerNotifyError:error];
            } else {
                if (!offlineData) {
                    [self generateDefaultAccount];
                }
                LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
                account.username = username;
                account.passwordmd5 = hash;
                [self handleLoginResponse:obj];
            }
        }
    }];
}

#pragma mark - Private -

- (void)observerNotifyError:(NSError *)error {
    for (id<ANAccountManagerObserver> observer in observers) {
        [observer accountManager:self loginFailed:error];
    }
}

- (void)observerLoggedIn {
    for (id<ANAccountManagerObserver> observer in observers) {
        [observer accountManagerLoggedIn:self];
    }
}

- (void)handleLoginResponse:(NSDictionary *)dict {
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    account.cubeScheme = [dict objectForKey:@"cubeScheme"];
    account.name = [dict objectForKey:@"name"];
    account.email = [dict objectForKey:@"email"];
    [self observerLoggedIn];
    
    [[ANSyncManager sharedSyncManager] startSyncing];
}

@end
