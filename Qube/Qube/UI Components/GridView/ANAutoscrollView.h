//
//  ANAutoscrollView.h
//  GridView
//
//  Created by Alex Nichol on 9/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANAutoscrollView : UIScrollView {
    UIView * contextView;
    NSTimer * contextTimer;
    CGFloat velocity;
}

- (void)beginContextForView:(UIView *)movingView;
- (void)contextUpdate;
- (void)endContext;

- (CGRect)scrollRectToView:(CGRect)r;
- (CGRect)viewRectToScroll:(CGRect)r;

@end
