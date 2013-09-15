//
//  ANLoadingKnob.m
//  BIS
//
//  Created by Alex Nichol on 8/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANLoadingKnob.h"

@interface ANLoadingKnob (Private)

- (void)setup;

@end

@implementation ANLoadingKnob

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    return self;
}

- (void)setup {    
    UIImage * image = [UIImage imageNamed:@"refresh"];
    refreshImage = [[UIImageView alloc] initWithImage:image];
    refreshImage.backgroundColor = [UIColor clearColor];
    refreshImage.frame = CGRectInset(self.bounds, 5, 5);
    [self addSubview:refreshImage];
}

- (void)setKnobImage:(UIImage *)image {
    refreshImage.image = image;
}

- (void)startLoading {
    if (isSpinning) return;
    self.userInteractionEnabled = NO;
    isSlowing = NO;
    isSpinning = YES;
    angle = 0;
    startDate = [NSDate date];
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateRoutine:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopLoading {
    if (isSpinning && !isSlowing) {
        isSlowing = YES;
        slowAngleStart = angle;
        stopDate = [NSDate date];
    }
}

- (void)animateRoutine:(id)sender {
    CGFloat newAngle = angle;
    if (isSlowing) {
        // d = v*t - 1/2*a*t^2 + start
        // d = 2*pi - start
        // v^2 = -2*a*d; => a = -v^2/(2*d)
        // v*t - 1/2*a*t^2 = 2*pi - start
        CGFloat acceleration = pow(kLoadingKnobVelocity, 2) / (2 * (2*M_PI - slowAngleStart));
        NSTimeInterval delay = [[NSDate date] timeIntervalSinceDate:stopDate];
        if (kLoadingKnobVelocity - acceleration * delay < 0) {
            newAngle = 0;
            [displayLink removeFromRunLoop:[NSRunLoop mainRunLoop]
                                   forMode:NSRunLoopCommonModes];
            displayLink = nil;
            isSpinning = NO;
            self.userInteractionEnabled = YES;
        } else {
            newAngle = (kLoadingKnobVelocity * delay) - (1.0/2.0 * acceleration * pow(delay, 2)) + slowAngleStart;
        }
    } else {
        NSTimeInterval totalTime = [[NSDate date] timeIntervalSinceDate:startDate];
        newAngle = kLoadingKnobVelocity * totalTime;
    }
    
    angle = newAngle;
    refreshImage.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    while (angle > 2*M_PI) {
        angle -= 2*M_PI;
    }
}

@end
