//
//  ANAPIReplaceRequest.h
//  Qube
//
//  Created by Alex Nichol on 8/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"
#import "ANPuzzle+Coding.h"

@interface ANAPICallPuzzleReplace : ANAPICall

- (id)initWithRemoteId:(NSData *)theId puzzle:(ANPuzzle *)localPuzzle;

@end
