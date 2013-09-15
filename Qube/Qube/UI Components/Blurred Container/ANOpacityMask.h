//
//  ANOpacityMask.h
//  BIS
//
//  Created by Alex Nichol on 8/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ANImageBitmapRep.h"

@interface ANOpacityMask : NSObject {
    CGFloat width;
    CGFloat stretch;
}

- (id)initWithWidth:(CGFloat)width stretch:(CGFloat)aStretch;

- (UIImage *)topMaskImage;
- (UIImage *)bottomMaskImage;

@end
