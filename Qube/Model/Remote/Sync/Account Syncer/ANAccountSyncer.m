//
//  ANAccountSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountSyncer.h"

@interface ANAccountSyncer (Private)

- (void)handleSetResponse:(NSDictionary *)dict;
- (void)handleGetAccount:(NSDictionary *)dict;

@end

@implementation ANAccountSyncer

@synthesize delegate;

- (id)initWithDelegate:(id<ANAccountSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        delegate = aDel;
        NSArray * changes = [[ANDataManager sharedDataManager].activeAccount.changes.accountChanges allObjects];
        ANAPICallAccountSet * set = [[ANAPICallAccountSet alloc] initWithAccountChanges:changes];
        [self sendAPICall:set returnSelector:@selector(handleSetResponse:)];
    }
    return self;
}

- (void)handleSetResponse:(NSDictionary *)dict {
    ANAPIAccountSetResponse * response = [[ANAPIAccountSetResponse alloc] initWithDictionary:dict];
    for (OCAccountChange * change in response.accountSettings) {
        [[ANDataManager sharedDataManager].context deleteObject:change];
    }
    // now we need to fetch the entire account again and assume ALL of its attributes
    ANAPICall * call = [[ANAPICall alloc] initWithAPI:@"account.getAccount"
                                               params:@{}];
    [self sendAPICall:call returnSelector:@selector(handleGetAccount:)];
}

- (void)handleGetAccount:(NSDictionary *)dict {
    LocalAccount * account = [ANDataManager sharedDataManager].activeAccount;
    NSDictionary * myObject = [account encodeAccount];
    if (![myObject isEqualToDictionary:dict]) {
        [account decodeAccount:dict];
        [delegate accountSyncer:self updatedAccount:account];
    }
}

@end
