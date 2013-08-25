//
//  ANAPIAccountSetResponse.m
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIAccountSetResponse.h"

@implementation ANAPIAccountSetResponse

@synthesize accountSettings;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        // see ANAPIPuzzleSetResponse.m for details on why this is implemented
        // the way that it is.
        NSMutableArray * mReqs = [NSMutableArray array];
        NSSet * accountChanges = [ANDataManager sharedDataManager].activeAccount.changes.accountChanges;
        for (NSDictionary * info in [dict objectForKey:@"attributes"]) {
            NSString * attr = [info objectForKey:@"attribute"];
            NSData * value = [info objectForKey:@"value"];
            for (OCAccountChange * change in accountChanges) {
                if ([change.attribute isEqualToString:attr]) {
                    if ([change.attributeValue isEqualToData:value]) {
                        [mReqs addObject:change];
                        break;
                    }
                }
            }
        }
        accountSettings = mReqs;
    }
    return self;
}

@end
