//
//  ANChangePasswordView.h
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredScrollLayout.h"
#import "ANAccountPage.h"
#import "ANPeriodicLineView.h"

@interface ANChangePasswordView : ANBlurredScrollLayout <ANAccountPage, UITextFieldDelegate> {
    UITextField * oldPasswordField;
    UITextField * passwordField;
    UITextField * confirmPasswordField;
    UIButton * changeButton;
    UIButton * cancelButton;
}

@property (readonly) UITextField * oldPasswordField;
@property (readonly) UITextField * passwordField;
@property (readonly) UITextField * confirmPasswordField;
@property (readonly) UIButton * changeButton;

@end
