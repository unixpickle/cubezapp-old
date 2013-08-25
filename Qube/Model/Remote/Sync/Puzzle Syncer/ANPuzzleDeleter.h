//
//  ANPuzzleDeleter.h
//  Qube
//
//  Created by Alex Nichol on 8/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleSyncer.h"
#import "ANAPICallPuzzleDelete.h"

@interface ANPuzzleDeleter : ANPuzzleSyncer {
    NSArray * theDeleteIds;
}

@end
