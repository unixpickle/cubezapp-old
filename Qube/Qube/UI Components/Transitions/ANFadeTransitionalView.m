//
//  ANFadeTransitionalView.m
//  Qube
//
//  Created by Alex Nichol on 9/4/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANFadeTransitionalView.h"

@implementation ANFadeTransitionalView

- (id)initWithFrame:(CGRect)frame view:(UIView *)aView {
    self = [super initWithFrame:frame];
    if (self) {
        currentView = aView;
        currentView.frame = self.bounds;
        [self addSubview:currentView];
    }
    return self;
}

- (void)transitionTo:(UIView *)view {
    if (view == currentView) return;
    [self setUserInteractionEnabled:NO];
    
    transitioningTo = view;
    transitioningTo.alpha = 0;
    transitioningTo.frame = self.bounds;
    if (transitioningTo) [self addSubview:transitioningTo];
    
    [UIView animateWithDuration:0.25 animations:^{
        currentView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.24 animations:^{
            transitioningTo.alpha = 1;
        } completion:^(BOOL finished) {
            [currentView removeFromSuperview];
            currentView = transitioningTo;
            [self setUserInteractionEnabled:YES];
        }];
    }];
}

- (void)changeView:(UIView *)newView {
    [currentView removeFromSuperview];
    currentView = newView;
    currentView.frame = self.bounds;
    [self addSubview:currentView];
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
