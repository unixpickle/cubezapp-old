//
//  ANPasswordButton.m
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPasswordButton.h"

@implementation ANPasswordButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        selectedBg = [[UIView alloc] initWithFrame:self.bounds];
        selectedBg.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        selectedBg.alpha = 0;
        [self addSubview:selectedBg];
        
        dotField = [[UITextField alloc] initWithFrame:self.bounds];
        dotField.backgroundColor = [UIColor clearColor];
        dotField.userInteractionEnabled = NO;
        dotField.secureTextEntry = YES;
        dotField.text = @"aaaaaa";
        [self addSubview:dotField];
        
        nextIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 26, (frame.size.height - 16) / 2,
                                                                      16, 16)];
        [nextIndicator setImage:[UIImage imageNamed:@"disclosure"]];
        [self addSubview:nextIndicator];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    selectedBg.frame = self.bounds;
    dotField.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
    nextIndicator.frame = CGRectMake(self.frame.size.width - 26,
                                     (self.frame.size.height - 16) / 2,
                                     16, 16);
}

- (void)select {
    selectedBg.alpha = 1;
}

- (void)deselect:(BOOL)animated {
    if (selectedBg.alpha == 0) return;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            selectedBg.alpha = 0;
        }];
    } else {
        selectedBg.alpha = 0;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self select];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self deselect:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGFloat y = [[touches anyObject] locationInView:self].y;
    if (y < -50 || y > self.frame.size.height + 50) {
        if (selectedBg.alpha == 1) [self deselect:YES];
    } else {
        if (selectedBg.alpha != 1) [self select];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGFloat y = [[touches anyObject] locationInView:self].y;
    if (y < -50 || y > self.frame.size.height + 50) {
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
        return;
    }
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
