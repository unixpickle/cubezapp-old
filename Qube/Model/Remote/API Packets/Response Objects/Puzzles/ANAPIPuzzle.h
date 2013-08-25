//
//  ANAPIPuzzleObj.h
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAPIPuzzle : NSObject {
    NSDictionary * dictionary;
}

@property (readonly) NSDictionary * dictionary;

- (id)initWithDictionary:(NSDictionary *)aDict;
- (NSData *)identifier;
- (NSData *)attributeValue:(NSString *)key;

@end
