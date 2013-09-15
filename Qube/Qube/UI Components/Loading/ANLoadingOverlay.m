//
//  ANLoadingOverlay.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANLoadingOverlay.h"

@implementation ANLoadingOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        knob = [[ANLoadingKnob alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 20, frame.size.height / 2 - 20, 40, 40)];
        [self addSubview:knob];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    return self;
}

+ (ANLoadingOverlay *)sharedOverlay {
    static ANLoadingOverlay * overlay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = [UIScreen mainScreen].bounds;
        overlay = [[ANLoadingOverlay alloc] initWithFrame:frame];
    });
    return overlay;
}

- (void)displayOverlay {
    if (isDisplayed) return;
    isDisplayed = YES;
    [knob startLoading];
    UIWindow * window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
}

- (void)hideOverlay {
    [knob stopLoading];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        isDisplayed = NO;
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
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
