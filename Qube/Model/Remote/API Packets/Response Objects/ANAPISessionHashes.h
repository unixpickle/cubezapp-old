//
//  ANAPISessionHashes.h
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAPISessionHashes : NSObject {
    NSDictionary * hashes;
    NSInteger prefLen;
    NSData * idPrefix;
}

@property (readonly) NSDictionary * hashes;
@property (readonly) NSInteger prefLen;
@property (readonly) NSData * idPrefix;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
