//
//  ANAPISessionGetHashes.h
//  Qube
//
//  Created by Alex Nichol on 8/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"

@interface ANAPISessionGetHashes : ANAPICall

- (id)initWithIdPrefix:(NSData *)query prefLen:(NSInteger)prefLen;

@end
