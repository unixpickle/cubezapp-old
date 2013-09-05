//
//  ANTransitionalView.h
//  BIS
//
//  Created by Alex Nichol on 8/13/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSlideTransitionalView : UIView {
    UIView * currentView;
    UIView * transitioningTo;
}

- (id)initWithFrame:(CGRect)frame view:(UIView *)contents;
- (void)pushToView:(UIView *)view;
- (void)popToView:(UIView *)view;

@end
