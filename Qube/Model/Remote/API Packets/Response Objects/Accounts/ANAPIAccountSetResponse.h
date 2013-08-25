//
//  ANAPIAccountSetResponse.h
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDataManager+Search.h"

@interface ANAPIAccountSetResponse : NSObject {
    NSArray * accountSettings;
}

@property (readonly) NSArray * accountSettings;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
