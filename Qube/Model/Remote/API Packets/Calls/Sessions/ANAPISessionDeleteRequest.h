//
//  ANAPISessionDeleteRequest.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"

@interface ANAPISessionDeleteRequest : ANAPICall

- (id)initWithIds:(NSArray *)ids;
- (id)initWithDeleteRequests:(NSArray *)deletions;

@end
