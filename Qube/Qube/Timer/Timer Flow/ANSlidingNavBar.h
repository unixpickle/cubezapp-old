//
//  ANSlidingNavBar.h
//  Qube
//
//  Created by Alex Nichol on 10/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSlidingNavBar : UIView {
    UIButton * backButton;
    UIButton * statsButton;
    UILabel * titleLabel;
}

@property (nonatomic, retain) UIButton * backButton;
@property (nonatomic, retain) UIButton * statsButton;
@property (readonly) UILabel * titleLabel;

@end
