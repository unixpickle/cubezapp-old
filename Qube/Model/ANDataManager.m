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
    NSArray * accountList = [context executeFetchRequest:request error:nil];
    NSAssert([accountList count] < 2, @"Too many active accounts in the data store.");
    if ([accountList count] == 1) {
        activeAccount = [accountList lastObject];
    }
    return activeAccount;
}

#pragma mark - Puzzles -

- (ANPuzzle *)createPuzzleObject {
    ANPuzzle * puzzle = [NSEntityDescription insertNewObjectForEntityForName:@"ANPuzzle"
                                                      inManagedObjectContext:context];
    puzzle.identifier = [NSData randomDataOfLength:16];
    return puzzle;
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
