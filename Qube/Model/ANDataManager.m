//
//  ANDataManager.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager.h"

@interface ANDataManager (Private)

- (NSString *)coreDataSavePath;
- (void)configureCoreData;

@end

@implementation ANDataManager

@synthesize context;

+ (ANDataManager *)sharedDataManager {
    static ANDataManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANDataManager alloc] init];
    });
    return manager;
}

- (id)init {
    if ((self = [super init])) {
        [self configureCoreData];
    }
    return self;
}

- (NSString *)coreDataSavePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/save.dat"];
}

- (void)configureCoreData {
    NSURL * accountsURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:accountsURL];
    context = [[NSManagedObjectContext alloc] init];
    
    NSPersistentStoreCoordinator * coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    [context setPersistentStoreCoordinator:coordinator];
    
    NSString * storeType = NSSQLiteStoreType;
    NSString * storeFile = [self coreDataSavePath];;
    
    NSError * error = nil;
    NSURL * url = [NSURL fileURLWithPath:storeFile];
    
    NSPersistentStore * newStore = [coordinator addPersistentStoreWithType:storeType
                                                             configuration:nil
                                                                       URL:url
                                                                   options:nil
                                                                     error:&error];
    
    if (newStore == nil) {
        NSLog(@"Store Configuration Failure: %@",
              ([error localizedDescription] != nil) ?
              [error localizedDescription] : @"Unknown Error");
    }
}

#pragma mark - Account Management -

- (LocalAccount *)activeAccount {
    if (activeAccount) return activeAccount;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:@"LocalAccount"]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"active == YES"]];
    NSArray * accountList = [context executeFetchRequest:request error:nil];
    NSAssert([accountList count] < 2, @"Too many active accounts in the data store.");
    if ([accountList count] == 0) {
        activeAccount = [NSEntityDescription insertNewObjectForEntityForName:@"LocalAccount"
                                                      inManagedObjectContext:context];
        [self generateDefaultAccount:activeAccount];
        [context save:nil];
    } else {
        activeAccount = [accountList lastObject];
    }
    return activeAccount;
}

- (void)switchToAccount:(LocalAccount *)anAccount {
    [self activeAccount].active = NO;
    anAccount.active = YES;
    [context save:nil];
    activeAccount = anAccount;
}

- (LocalAccount *)localAccountForUsername:(NSString *)username {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[[model entitiesByName] objectForKey:@"LocalAccount"]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"username == %@", username]];
    NSArray * accountList = [context executeFetchRequest:request error:nil];
    LocalAccount * account = [accountList firstObject];
    if (!account) {
        account = [NSEntityDescription insertNewObjectForEntityForName:@"LocalAccount"
                                                inManagedObjectContext:context];
        account.username = username;
        [context save:nil];
    }
    return account;
}

- (void)generateDefaultAccount:(LocalAccount *)account {
    
}

#pragma mark - Puzzles -

- (ANPuzzle *)createPuzzleObject {
    return [NSEntityDescription insertNewObjectForEntityForName:@"ANPuzzle"
                                         inManagedObjectContext:context];
}

- (ANSession *)createSessionObject {
    return [NSEntityDescription insertNewObjectForEntityForName:@"ANSession"
                                         inManagedObjectContext:context];
}

- (ANSolve *)createSolveObject {
    return [NSEntityDescription insertNewObjectForEntityForName:@"ANSolve"
                                         inManagedObjectContext:context];
}

@end
