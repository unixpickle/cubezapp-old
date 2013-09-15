//
//  ANBluredContainerView.m
//  Qube
//
//  Created by Alex Nichol on 9/10/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredContainerView.h"

@interface ANBlurredContainerView (Private)

- (void)generateMask;

@end

@implementation ANBlurredContainerView

- (void)generateMask {
    // TODO: we need to make the CALayer resizeable so that we are able
    // to animate a resize
    ANOpacityMask * mask = [[ANOpacityMask alloc] initWithWidth:self.frame.size.width
                                                        stretch:[UIScreen mainScreen].scale * 10];
    CALayer * topLayer = [CALayer layer];
    topLayer.contents = (id)[mask topMaskImage].CGImage;
    topLayer.frame = CGRectMake(0, 0, self.frame.size.width, 10);
    
    
    CALayer * bottomLayer = [CALayer layer];
    bottomLayer.contents = (id)[mask bottomMaskImage].CGImage;
    bottomLayer.frame = CGRectMake(0, self.frame.size.height - 10, self.frame.size.width, 10);
    
    CALayer * middleLayer = [CALayer layer];
    middleLayer.backgroundColor = [UIColor blackColor].CGColor;
    middleLayer.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 20);
    
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [maskLayer addSublayer:topLayer];
    [maskLayer addSublayer:middleLayer];
    [maskLayer addSublayer:bottomLayer];
    self.layer.mask = maskLayer;
    
    maskTop = topLayer;
    maskBottom = bottomLayer;
    maskMiddle = middleLayer;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self generateMask];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:[CATransaction animationDuration]]
                     forKey:kCATransactionAnimationDuration];
    
    maskTop.frame = CGRectMake(0, 0, self.frame.size.width, 10);
    maskMiddle.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 20);
    maskBottom.frame = CGRectMake(0, self.frame.size.height - 10, self.frame.size.width, 10);
    
    [CATransaction commit];    
}

@end
