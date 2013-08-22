//
//  ANSessionDeleter.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleSyncer.h"
#import "ANAPISessionDeleteRequest.h"

@interface ANSessionDeleter : ANPuzzleSyncer {
    NSArray * deleteRequests;
}

@end
