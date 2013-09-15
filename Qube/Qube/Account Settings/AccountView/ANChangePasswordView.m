//
//  ANChangePasswordView.m
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANChangePasswordView.h"

@interface ANChangePasswordView (Private)

- (void)createFields;
- (void)createButton;

@end

@implementation ANChangePasswordView

@synthesize oldPasswordField;
@synthesize passwordField;
@synthesize confirmPasswordField;
@synthesize changeButton;

- (UIControl *)button {
    if (cancelButton) return cancelButton;
    cancelButton = [[UIButton alloc] initWithFrame:kANAccountPageButtonFrame];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:kANAccountPageButtonFont];
    return cancelButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [scrollView addSpacing:10];
        [self createFields];
        [scrollView addSpacing:10];
        [self createButton];
        [scrollView addSpacing:10];
    }
    return self;
}

- (void)createFields {
    ANPeriodicLineView * container = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 44*3)];
    
    CGFloat fieldWidth = container.frame.size.width - 20;
    oldPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, fieldWidth, 44)];
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44, fieldWidth, 44)];
    confirmPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44*2, fieldWidth, 44)];
    
    oldPasswordField.placeholder = @"Current Password";
    passwordField.placeholder = @"New Password";
    confirmPasswordField.placeholder = @"Retype New Password";
    confirmPasswordField.returnKeyType = UIReturnKeyDone;
    
    for (UITextField * field in @[oldPasswordField, passwordField, confirmPasswordField]) {
        [container addSubview:field];
        [field setBackgroundColor:[UIColor clearColor]];
        [field setBorderStyle:UITextBorderStyleNone];
        [field setSecureTextEntry:YES];
        field.delegate = self;
    }
    
    [scrollView addView:container];
}

- (void)createButton {
    changeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 50)];
    [changeButton setBackgroundImage:[UIImage imageNamed:@"loginbutton"]
                            forState:UIControlStateNormal];
    [changeButton setTitle:@"Change Password" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scrollView addView:changeButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSArray * fields = @[oldPasswordField, passwordField, confirmPasswordField];
    NSInteger index = [fields indexOfObject:textField];
    if (index == [fields count] - 1) {
        [textField resignFirstResponder];
    } else {
        [[fields objectAtIndex:(index + 1)] becomeFirstResponder];
    }
    return NO;
}

@end
