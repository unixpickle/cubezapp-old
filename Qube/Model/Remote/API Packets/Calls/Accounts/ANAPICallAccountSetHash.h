//
//  ANAPICallAccountSetHash.h
//  Qube
//
//  Created by Alex Nichol on 9/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPIBaseCall.h"
#import "ANDataManager.h"
#import "NSData+MD5.h"

@interface ANAPICallAccountSetHash : ANAPIBaseCall

- (id)initWithOldPassword:(NSString *)old newPassword:(NSString *)newPassword;

@end
