//
//  ANMaskedBanner.m
//  Qube
//
//  Created by Alex Nichol on 9/5/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANMaskedBanner.h"

@implementation ANMaskedBanner

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        maskedImage = [UIImage imageNamed:@"cubezapptextlogo_grids"];
        plainImage = [UIImage imageNamed:@"cubezapptextlogo"];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)startAnimating {
    if (link) return;
    link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationIteration)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAnimating {
    [link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    link = nil;
}

- (void)animationIteration {
    xOffset += link.duration;
    while (xOffset >= 1) {
        xOffset -= 1.2;
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat height = (self.frame.size.width / plainImage.size.width) * plainImage.size.height;
    CGFloat offset = (self.frame.size.height - height) / 2.0;
    CGRect fillRect = CGRectMake(0, offset, self.frame.size.width, height);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [plainImage drawInRect:fillRect];
    CGContextBeginPath(context);
    CGContextClipToRect(context, CGRectMake(xOffset * self.frame.size.width, 0,
                                            self.frame.size.width / 5.0, self.frame.size.height));
    [maskedImage drawInRect:fillRect];
    CGContextRestoreGState(context);
}

@end
