//
//  ANBluredContainerView.h
//  Qube
//
//  Created by Alex Nichol on 9/10/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANOpacityMask.h"

@interface ANBlurredContainerView : UIView {
    CALayer * maskTop;
    CALayer * maskBottom;
    CALayer * maskMiddle;
}

@end
