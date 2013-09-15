//
//  ANPasswordButton.h
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANPasswordButton : UIControl {
    UITextField * dotField;
    UIImageView * nextIndicator;
    UIView * selectedBg;
}

- (void)select;	
- (void)deselect:(BOOL)animated;

@end
