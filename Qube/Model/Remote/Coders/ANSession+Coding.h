//
//  ANSessionCoder.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDataManager.h"

@interface ANSession (Coding)

- (NSDictionary *)encodeSession;
- (void)decodeSession:(NSDictionary *)dict;

@end
