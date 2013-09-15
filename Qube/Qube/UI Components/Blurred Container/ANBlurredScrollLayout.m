//
//  ANBlurredScrollLayout.m
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredScrollLayout.h"

@implementation ANBlurredScrollLayout

@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        scrollView = [[ANListLayout alloc] initWithFrame:self.bounds];
        scrollView.alwaysBounceVertical = YES;
        [self addSubview:scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    scrollView.frame = self.bounds;
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
