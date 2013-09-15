//
//  ANSigninView.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSigninView.h"

@interface ANSigninView (Private)

- (void)loginPressed:(id)sender;

@end

@implementation ANSigninView

@synthesize usernameField;
@synthesize passwordField;
@synthesize target, action;
@synthesize banner;
@synthesize loginButton;

- (UIButton *)button {
    if (signupButton) return signupButton;
    signupButton = [[UIButton alloc] initWithFrame:kANAccountPageButtonFrame];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [signupButton setTitle:@"Sign Up!" forState:UIControlStateNormal];
    [signupButton.titleLabel setFont:kANAccountPageButtonFont];
    return signupButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        fieldsContainer = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 74, frame.size.width - 20, 88)];
        
        usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, fieldsContainer.frame.size.width - 20, 44)];
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 44, fieldsContainer.frame.size.width - 20, 44)];
        
        usernameField.placeholder = @"Username";
        passwordField.placeholder = @"Password";
        
        usernameField.borderStyle = UITextBorderStyleNone;
        passwordField.borderStyle = UITextBorderStyleNone;
        
        usernameField.delegate = self;
        passwordField.delegate = self;
        
        usernameField.returnKeyType = UIReturnKeyNext;
        passwordField.returnKeyType = UIReturnKeyDone;
        
        [fieldsContainer addSubview:usernameField];
        [fieldsContainer addSubview:passwordField];
        
        [self addSubview:fieldsContainer];
        self.backgroundColor = [UIColor clearColor];
        
        usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
        passwordField.secureTextEntry = YES;
        
        banner = [[ANMaskedBanner alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:banner];
        [banner startAnimating];
        
        loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, fieldsContainer.frame.origin.y + 88 + 5,
                                                                 fieldsContainer.frame.size.width,
                                                                 50)];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"loginbutton"]
                     forState:UIControlStateNormal];
        [loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginPressed:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // this code is pretty ugly, but you can't tell me
    // it doesn't work.
    
    NSLog(@"height %f", self.frame.size.height);
    
    CGFloat bannerHeight = self.frame.size.height < 200 ? 50 : 64;
    CGFloat bannerWidth = 320.0 * bannerHeight / 64.0;
    
    CGFloat headerSpacing = (self.frame.size.height - 160) / 10;
    CGFloat totalHeight = bannerHeight + headerSpacing + 88 + 55;
    CGFloat yBase = self.frame.size.height / 2 - 20 * (self.frame.size.height / 400);
    banner.frame = CGRectMake((self.frame.size.width - bannerWidth) / 2.0,
                              yBase - (totalHeight / 2),
                              bannerWidth, bannerHeight);
    fieldsContainer.frame = CGRectMake(10, banner.frame.origin.y + bannerHeight + headerSpacing,
                                       self.frame.size.width - 20, 88);
    loginButton.frame = CGRectMake(10, fieldsContainer.frame.origin.y + 88 + 5,
                                   self.frame.size.width - 20, 50);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (usernameField.isFirstResponder) {
        [passwordField becomeFirstResponder];
    } else {
        [passwordField resignFirstResponder];
    }
    return NO;
}

- (void)loginPressed:(id)sender {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    NSMethodSignature * signature = [self.target methodSignatureForSelector:self.action];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:self.action];
    [invocation setTarget:self.target];
    [invocation invoke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
