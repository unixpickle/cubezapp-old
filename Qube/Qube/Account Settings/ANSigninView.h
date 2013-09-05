//
//  ANSigninView.h
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPeriodicLineView.h"
#import "ANMaskedBanner.h"

@interface ANSigninView : UIView <UITextFieldDelegate> {
    UIView * fieldsContainer;
    UITextField * usernameField;
    UITextField * passwordField;
    ANMaskedBanner * banner;
    UIButton * loginButton;
}

@property (readonly) UITextField * usernameField;
@property (readonly) UITextField * passwordField;
@property (weak) id target;
@property (readwrite) SEL action;
@property (readonly) ANMaskedBanner * banner;

@end
