//
//  ANAPICallImageUpload.h
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"

@interface ANAPICallImageUpload : ANAPICall

- (id)initWithHash:(NSData *)hash data:(NSData *)data;

@end
