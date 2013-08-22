//
//  ANAPISessionGetDiff.h
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"

@interface ANAPISessionGetDiff : ANAPICall

- (id)initWithIdPrefix:(NSData *)query ids:(NSArray *)ids;
- (id)initWithIdPrefix:(NSData *)query sessions:(NSArray *)sessions;

@end
