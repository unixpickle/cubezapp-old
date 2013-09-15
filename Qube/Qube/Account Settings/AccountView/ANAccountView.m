//
//  ANAccountView.m
//  Qube
//
//  Created by Alex Nichol on 9/10/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountView.h"

@interface ANAccountView (Private)

- (void)createFields;

@end

@implementation ANAccountView

@synthesize delegate;
@synthesize emailField;
@synthesize nameField;
@synthesize passwordButton;
@synthesize syncView;

- (UIControl *)button {
    if (logoutButton) return logoutButton;
    logoutButton = [[UIButton alloc] initWithFrame:kANAccountPageButtonFrame];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [logoutButton setTitle:@"Signout" forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:kANAccountPageButtonFont];
    return logoutButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [scrollView addSpacing:10];
        [self createFields];
        [scrollView addSpacing:20];
        
        syncView = [[ANAccountSyncView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 88)];
        [scrollView addView:syncView];
        [scrollView addSpacing:10];
        
        [passwordButton addTarget:self action:@selector(passwordPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        [syncView.loadingKnob addTarget:self action:@selector(syncPressed:)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)createFields {
    ANPeriodicLineView * container = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 44*3)];
    
    CGFloat fieldWidth = container.frame.size.width - 20;
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, fieldWidth, 44)];
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44, fieldWidth, 44)];
    
    [emailField setKeyboardType:UIKeyboardTypeEmailAddress];

    for (UITextField * field in @[emailField, nameField]) {
        [container addSubview:field];
        [field setBackgroundColor:[UIColor clearColor]];
        [field setBorderStyle:UITextBorderStyleNone];
        [field setDelegate:self];
        [field setReturnKeyType:UIReturnKeyDone];
    }
    
    passwordButton = [[ANPasswordButton alloc] initWithFrame:CGRectMake(0, 44*2, container.frame.size.width,
                                                                        44)];
    [container addSubview:passwordButton];
    
    [scrollView addView:container];
}

#pragma mark - Actions -

- (void)passwordPressed:(id)sender {
    [self.delegate accountViewPasswordPressed:self];
}

- (void)syncPressed:(id)sender {
    [self.delegate accountViewSyncPressed:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == emailField) {
        [self.delegate accountView:self emailSet:textField.text];
    } else {
        [self.delegate accountView:self nameSet:textField.text];
    }
    [textField resignFirstResponder];
    return NO;
}

@end
