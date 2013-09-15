//
//  ANSignupView.m
//  Qube
//
//  Created by Alex Nichol on 9/4/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSignupView.h"

@interface ANSignupView (Private)

- (void)createFields;
- (void)createButton;

- (void)signupPressed:(id)sender;

@end

@implementation ANSignupView

@synthesize target;
@synthesize action;
@synthesize usernameField;
@synthesize emailField;
@synthesize nameField;
@synthesize passwordField;
@synthesize confirmField;

- (UIControl *)button {
    if (cancelButton) return cancelButton;
    cancelButton = [[UIButton alloc] initWithFrame:kANAccountPageButtonFrame];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:kANAccountPageButtonFont];
    return cancelButton;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        infoFields = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 44*3)];
        passFields = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 44*2)];
        
        [scrollView addSpacing:10];
        [scrollView addView:infoFields];
        [scrollView addSpacing:20];
        [scrollView addView:passFields];
        [scrollView addSpacing:20];
        
        [self createFields];
        [self createButton];
        
        [scrollView addSpacing:10];
    }
    return self;
}

- (void)createFields {
    CGFloat fieldWidth = infoFields.frame.size.width - 20;
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, fieldWidth, 44)];
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44, fieldWidth, 44)];
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 88, fieldWidth, 44)];
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, fieldWidth, 44)];
    confirmField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44, fieldWidth, 44)];
    
    usernameField.placeholder = @"Username";
    emailField.placeholder = @"Email";
    nameField.placeholder = @"Full Name";
    passwordField.placeholder = @"Password";
    confirmField.placeholder = @"Confirm Password";
    
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    
    for (UITextField * field in @[usernameField, emailField, nameField, passwordField, confirmField]) {
        field.borderStyle = UITextBorderStyleNone;
        field.delegate = self;
        field.returnKeyType = UIReturnKeyNext;
    }
    
    [infoFields addSubview:usernameField];
    [infoFields addSubview:emailField];
    [infoFields addSubview:nameField];
    
    passwordField.secureTextEntry = YES;
    confirmField.secureTextEntry = YES;
    confirmField.returnKeyType = UIReturnKeyDone;
    
    [passFields addSubview:passwordField];
    [passFields addSubview:confirmField];
}

- (void)createButton {
    signupButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 50)];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"loginbutton"]
                           forState:UIControlStateNormal];
    [signupButton setTitle:@"Signup" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(signupPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    [scrollView addView:signupButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSArray * fields = @[usernameField, emailField, nameField, passwordField, confirmField];
    NSInteger idx = [fields indexOfObject:textField];
    if (idx == [fields count] - 1) {
        [textField resignFirstResponder];
    } else {
        [fields[idx + 1] becomeFirstResponder];
    }
    return NO;
}

- (void)signupPressed:(id)sender {
    NSArray * fields = @[usernameField, emailField, nameField, passwordField, confirmField];
    for (UIView * f in fields) {
        if ([f isFirstResponder]) [f resignFirstResponder];
    }
    NSMethodSignature * signature = [self.target methodSignatureForSelector:self.action];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:self.action];
    [invocation setTarget:self.target];
    [invocation invoke];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

@end
