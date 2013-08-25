//
//  ANAPIDeleteRequest.h
//  Qube
//
//  Created by Alex Nichol on 8/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"

@interface ANAPICallPuzzleDelete : ANAPICall

- (id)initWithPuzzleIds:(NSArray *)identifiers;

@end
