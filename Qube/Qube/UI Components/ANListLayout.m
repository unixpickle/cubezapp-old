//
//  ANListLayout.m
//  Qube
//
//  Created by Alex Nichol on 9/8/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANListLayout.h"

@implementation ANListLayout

- (void)addView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin.y = contentHeight;
    view.frame = frame;
    [self addSubview:view];
    [self addSpacing:frame.size.height];
}

- (void)addSpacing:(CGFloat)size {
    contentHeight += size;
    self.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
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
