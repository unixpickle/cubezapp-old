//
//  ANSigninView.h
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountPage.h"

#import "ANPeriodicLineView.h"
#import "ANMaskedBanner.h"

@interface ANSigninView : UIView <UITextFieldDelegate, ANAccountPage> {
    UIView * fieldsContainer;
    UITextField * usernameField;
    UITextField * passwordField;
    ANMaskedBanner * banner;
    UIButton * loginButton;
    UIButton * signupButton;
}

@property (readonly) UITextField * usernameField;
@property (readonly) UITextField * passwordField;
@property (weak) id target;
@property (readwrite) SEL action;
@property (readonly) ANMaskedBanner * banner;
@property (readonly) UIButton * loginButton;

@end
