//
//  ANListLayout.h
//  Qube
//
//  Created by Alex Nichol on 9/8/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANListLayout : UIScrollView {
    CGFloat contentHeight;
}

- (void)addView:(UIView *)view;
- (void)addSpacing:(CGFloat)size;

@end
