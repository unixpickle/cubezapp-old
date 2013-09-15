//
//  ANFadeTransitionalView.h
//  Qube
//
//  Created by Alex Nichol on 9/4/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANFadeTransitionalView : UIView {
    UIView * currentView;
    UIView * transitioningTo;
}

- (id)initWithFrame:(CGRect)frame view:(UIView *)aView;
- (void)transitionTo:(UIView *)view;
- (void)changeView:(UIView *)newView;

@end
