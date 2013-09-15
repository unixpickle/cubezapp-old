//
//  LocalAccount+AttrSetters.m
//  Qube
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "LocalAccount+AttrSetters.h"

OCAccountChange * createChange(NSString * attribute);

@implementation LocalAccount (AttrSetters)

- (void)offlineSetCubeScheme:(NSData *)cubeScheme {
    OCAccountChange * change = createChange(kANAccountAttributeCubeScheme);
    change.attributeValue = cubeScheme;
    self.cubeScheme = cubeScheme;
}

- (void)offlineSetName:(NSString *)name {
    OCAccountChange * change = createChange(kANAccountAttributeName);
    change.attributeValue = [name dataUsingEncoding:NSUTF8StringEncoding];
    self.name = name;
}

@end

OCAccountChange * createChange(NSString * attribute) {
    OCAccountChange * change = [[ANDataManager sharedDataManager] findAccountChangeForAttribute:attribute];
    if (change) return change;
    change = [NSEntityDescription insertNewObjectForEntityForName:@"OCAccountChange"
                                           inManagedObjectContext:[ANDataManager sharedDataManager].context];
    change.attribute = attribute;
    [[ANDataManager sharedDataManager].activeAccount.changes addAccountChangesObject:change];
    return change;
}
