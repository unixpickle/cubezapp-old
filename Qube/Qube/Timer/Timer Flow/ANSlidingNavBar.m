//
//  ANSlidingNavBar.m
//  Qube
//
//  Created by Alex Nichol on 10/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSlidingNavBar.h"

@implementation ANSlidingNavBar

@synthesize titleLabel;

- (void)setBackButton:(UIButton *)aButton {
    [backButton removeFromSuperview];
    backButton = aButton;
    [self addSubview:backButton];
}

- (void)setStatsButton:(UIButton *)aButton {
    [statsButton removeFromSuperview];
    statsButton = aButton;
    [self addSubview:statsButton];
}

- (UIButton *)backButton {
    return backButton;
}

- (UIButton *)statsButton {
    return statsButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:244.0/255.0 alpha:1];
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [backButton sizeToFit];
    [statsButton sizeToFit];
    titleLabel.frame = self.bounds;
    backButton.frame = CGRectMake(15, 0, backButton.frame.size.width, self.frame.size.height);
    statsButton.frame = CGRectMake(self.frame.size.width - statsButton.frame.size.width - 15, 0,
                                   statsButton.frame.size.width, self.frame.size.height);
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
