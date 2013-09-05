//
//  ANPeriodicLineView.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPeriodicLineView.h"

@implementation ANPeriodicLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetGrayFillColor(context, 0.8, 1);
    for (CGFloat y = 44; y <= self.frame.size.height - 1; y += 44) {
        CGContextFillRect(context, CGRectMake(0, y, self.frame.size.width, 1));
    }
}

@end
