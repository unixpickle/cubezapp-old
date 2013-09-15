//
//  ANSignupView.h
//  Qube
//
//  Created by Alex Nichol on 9/4/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredScrollLayout.h"
#import "ANAccountPage.h"
#import "ANPeriodicLineView.h"

@interface ANSignupView : ANBlurredScrollLayout <UITextFieldDelegate, ANAccountPage> {    
    UITextField * usernameField;
    UITextField * emailField;
    UITextField * nameField;
    UITextField * passwordField;
    UITextField * confirmField;
    
    ANPeriodicLineView * infoFields;
    ANPeriodicLineView * passFields;
    
    UIButton * signupButton;
    UIButton * cancelButton;
}

@property (readonly) UITextField * usernameField;
@property (readonly) UITextField * emailField;
@property (readonly) UITextField * nameField;
@property (readonly) UITextField * passwordField;
@property (readonly) UITextField * confirmField;
@property (nonatomic, weak) id target;
@property (readwrite) SEL action;

@end
