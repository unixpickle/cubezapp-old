//
//  ANBlurredScrollLayout.h
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredContainerView.h"
#import "ANListLayout.h"

@interface ANBlurredScrollLayout : ANBlurredContainerView {
    ANListLayout * scrollView;
}

@property (readonly) ANListLayout * scrollView;

@end
