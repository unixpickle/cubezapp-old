//
//  ANSigninView.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSigninView.h"

@implementation ANSigninView

@synthesize usernameField;
@synthesize passwordField;
@synthesize target, action;
@synthesize banner;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        fieldsContainer = [[ANPeriodicLineView alloc] initWithFrame:CGRectMake(10, 74, frame.size.width - 20, 88)];
        fieldsContainer.layer.cornerRadius = 5;
        fieldsContainer.backgroundColor = [UIColor whiteColor];
        
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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat headerSpacing = self.frame.size.height / 10;
    CGFloat totalHeight = 64 + headerSpacing + 88;
    CGFloat yBase = self.frame.size.height / 2 - 20 * (self.frame.size.height / 400);
    banner.frame = CGRectMake(0, yBase - (totalHeight / 2),
                              self.frame.size.width, 64);
    fieldsContainer.frame = CGRectMake(10, banner.frame.origin.y + 64 + headerSpacing,
                                       self.frame.size.width - 20, 88);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (usernameField.isFirstResponder) {
        [passwordField becomeFirstResponder];
    } else {
        NSMethodSignature * signature = [self.target methodSignatureForSelector:self.action];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:self.action];
        [invocation setTarget:self.target];
        [invocation invoke];
        [passwordField resignFirstResponder];
    }
    return NO;
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
