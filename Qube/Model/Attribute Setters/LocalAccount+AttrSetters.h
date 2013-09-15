//
//  LocalAccount+AttrSetters.h
//  Qube
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"
#import "LocalAccount+Coding.h"

@interface LocalAccount (AttrSetters)

- (void)offlineSetCubeScheme:(NSData *)cubeScheme;
- (void)offlineSetName:(NSString *)name;

@end
