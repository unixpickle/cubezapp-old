//
//  ANSessionDeleter.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleSyncer.h"
#import "ANAPICallSessionDeleteRequest.h"

@interface ANSessionDeleter : ANPuzzleSyncer {
    NSArray * theDeleteIds;
}

@end
