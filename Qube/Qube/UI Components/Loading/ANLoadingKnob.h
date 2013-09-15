//
//  ANLoadingKnob.h
//  BIS
//
//  Created by Alex Nichol on 8/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kLoadingKnobVelocity 6.0

@interface ANLoadingKnob : UIControl {
    UIImageView * refreshImage;
    CADisplayLink * displayLink;
    
    CGFloat angle;
        
    CGFloat slowAngleStart;
    BOOL isSlowing;
    BOOL isSpinning;
    NSDate * stopDate;
    NSDate * startDate;
}

- (void)setKnobImage:(UIImage *)image;

- (void)startLoading;
- (void)stopLoading;

- (void)animateRoutine:(id)sender;

@end
