//
//  ANOpacityMask.m
//  BIS
//
//  Created by Alex Nichol on 8/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANOpacityMask.h"

static CGFloat transparencyFunction(CGFloat x);

@implementation ANOpacityMask

- (id)initWithWidth:(CGFloat)theWidth stretch:(CGFloat)aStretch {
    if ((self = [super init])) {
        width = theWidth;
        stretch = aStretch;
    }
    return self;
}

- (UIImage *)topMaskImage {
    ANImageBitmapRep * image = [[ANImageBitmapRep alloc] initWithSize:BMPointMake(width,
                                                                                  stretch)];
    CGContextRef context = [image context];
    for (int i = 0; i < stretch; i++) {
        CGFloat xVal = (CGFloat)(stretch - i) / stretch;
        CGFloat alpha = transparencyFunction(xVal);
        CGContextSetGrayFillColor(context, 0, alpha);
        CGContextFillRect(context, CGRectMake(0, i, width, 1));
    }
    [image setNeedsUpdate:YES];
    
    return [image image];
}

- (UIImage *)bottomMaskImage {
    ANImageBitmapRep * image = [[ANImageBitmapRep alloc] initWithSize:BMPointMake(width,
                                                                                  stretch)];
    CGContextRef context = [image context];
    for (int i = 0; i < stretch; i++) {
        CGFloat xVal = (CGFloat)(i) / stretch;
        CGFloat alpha = transparencyFunction(xVal);
        CGContextSetGrayFillColor(context, 0, alpha);
        CGContextFillRect(context, CGRectMake(0, i, width, 1));
    }
    [image setNeedsUpdate:YES];
    
    return [image image];
}

@end

static CGFloat transparencyFunction(CGFloat x) {
    return pow(x, 2);
}
