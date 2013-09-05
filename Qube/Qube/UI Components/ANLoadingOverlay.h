//
//  ANLoadingOverlay.h
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLoadingKnob.h"

@interface ANLoadingOverlay : UIView {
    ANLoadingKnob * knob;
}

+ (ANLoadingOverlay *)sharedOverlay;
- (void)displayOverlay;
- (void)hideOverlay;

@end
