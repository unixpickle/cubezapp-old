//
//  ANAPIDeleteRename.h
//  Qube
//
//  Created by Alex Nichol on 8/17/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"

@interface ANAPIDeleteRename : ANAPICall

- (id)initWithRemoteId:(NSData *)remoteId renameId:(NSData *)localId
                  name:(NSString *)name;

@end
