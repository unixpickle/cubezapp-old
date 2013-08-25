//
//  ANAPIDeleteResponse.h
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"

@interface ANAPIPuzzleDeleteResponse : NSObject {
    NSArray * requests;
}

@property (readonly) NSArray * requests;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
