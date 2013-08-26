//
//  ANAPIImageDownloadResponse.h
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANAPIImageDownloadResponse : NSObject {
    NSData * hash;
    NSData * data;
}

@property (readonly) NSData * hash;
@property (readonly) NSData * data;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
