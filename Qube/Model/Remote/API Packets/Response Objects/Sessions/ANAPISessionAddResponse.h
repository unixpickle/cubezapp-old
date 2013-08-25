//
//  ANAPISessionAddResponse.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDataManager+Search.h"

@interface ANAPISessionAddResponse : NSObject {
    NSArray * sessions;
}

@property (readonly) NSArray * sessions;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
