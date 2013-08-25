//
//  ANAPIAccountSet.h
//  Qube
//
//  Created by Alex Nichol on 8/24/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"

@interface ANAPICallAccountSet : ANAPICall

- (id)initWithAccountChanges:(NSArray *)changes;

@end
