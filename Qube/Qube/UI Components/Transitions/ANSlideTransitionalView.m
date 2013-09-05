//
//  ANTransitionalView.m
//  BIS
//
//  Created by Alex Nichol on 8/13/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSlideTransitionalView.h"

@interface ANSlideTransitionalView (Private)

- (void)transitionTo:(UIView *)view push:(BOOL)push;

@end

@implementation ANSlideTransitionalView

- (void)layoutSubviews {
    CGRect frame = currentView.frame;
    frame.size = self.bounds.size;
    currentView.frame = frame;
    [self layoutIfNeeded];
}

- (id)initWithFrame:(CGRect)frame view:(UIView *)contents {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:contents];
        currentView = contents;
        [self layoutSubviews];
    }
    return self;
}

- (void)pushToView:(UIView *)view {
    [self transitionTo:view push:YES];
}

- (void)popToView:(UIView *)view {
    [self transitionTo:view push:NO];
}

- (void)transitionTo:(UIView *)view push:(BOOL)push {
    [self setUserInteractionEnabled:NO];
    
    transitioningTo = view;
    CGRect dest = currentView.frame;
    if (push) {
        transitioningTo.frame = CGRectMake(self.frame.size.width, dest.origin.y,
                                           dest.size.width, dest.size.height);
    } else {
        transitioningTo.frame = CGRectMake(-self.frame.size.width, dest.origin.y,
                                           dest.size.width, dest.size.height);
    }
    
    [self addSubview:transitioningTo];
    
    [UIView animateWithDuration:0.5 animations:^{
        transitioningTo.frame = dest;
        if (push) {
            currentView.frame = CGRectMake(-self.frame.size.width, dest.origin.y,
                                           dest.size.width, dest.size.height);
        } else {
            currentView.frame = CGRectMake(self.frame.size.width, dest.origin.y,
                                           dest.size.width, dest.size.height);
        }
    } completion:^(BOOL finished) {
        [currentView removeFromSuperview];
        currentView = transitioningTo;
        [self setUserInteractionEnabled:YES];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
