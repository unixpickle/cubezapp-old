//
//  ANAPISessionAddRequest.h
//  Qube
//
//  Created by Alex Nichol on 8/20/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAPICall.h"
#import "ANDataManager.h"
#import "ANSession+Coding.h"

@interface ANAPICallSessionAdd : ANAPICall {
    
}

- (id)initWithAddRequests:(NSArray *)objects;

@end
