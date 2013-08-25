//
//  ANAPISetResponse.h
//  Qube
//
//  Created by Alex Nichol on 8/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"

@interface ANAPIPuzzleSetResponse : NSObject {
    NSArray * setRequests;
}

@property (readonly) NSArray * setRequests;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
