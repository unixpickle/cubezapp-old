//
//  ANMaskedBanner.h
//  Qube
//
//  Created by Alex Nichol on 9/5/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANMaskedBanner : UIView {
    UIImage * maskedImage;
    UIImage * plainImage;
    CADisplayLink * link;
    
    CGFloat xOffset;
}

- (void)startAnimating;
- (void)stopAnimating;
- (void)animationIteration;

@end
