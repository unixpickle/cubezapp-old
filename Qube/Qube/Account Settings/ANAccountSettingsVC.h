//
//  ANAccountSettingsVC.h
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANSigninView.h"
#import "ANSignupView.h"
#import "ANAccountView.h"
#import "ANChangePasswordView.h"

#import "ANLoadingOverlay.h"
#import "ANSlideTransitionalView.h"
#import "ANFadeTransitionalView.h"

#import "ANAPICallSignup.h"
#import "ANAPICallAccountSetHash.h"
#import "ANAPICallAccountSetEmail.h"

#import "LocalAccount+AttrSetters.h"

#define kTopSpacing 70
#define kBottomSpacing 80

@interface ANAccountSettingsVC : UIViewController <UIAlertViewDelegate, ANAccountViewDelegate> {
    UIButton * backButton;
    
    ANSigninView * signinView;
    ANSignupView * signupView;
    ANAccountView * accountView;
    ANChangePasswordView * passwordView;
    ANSlideTransitionalView * transitionalView;
        
    ANFadeTransitionalView * buttonTransition;
    ANFadeTransitionalView * usernameContainer;
    UILabel * usernameLabel;
}

@property (readonly) ANAccountView * accountView;

- (void)presentPage:(UIView<ANAccountPage> *)page forward:(BOOL)forward;
- (void)jumpToPage:(UIView<ANAccountPage> *)page;

- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;

// general buttons
- (void)backPressed:(id)sender;
- (void)signupPressed:(id)sender;
- (void)cancelSignupPressed:(id)sender;
- (void)logoutPressed:(id)sender;
- (void)cancelPasswordPressed:(id)sender;

// login
- (void)loggedIn;
- (void)updateSigninPage;
- (void)handleSigninFailed:(NSError *)error;
- (void)handleSignedIn;

// signup
- (void)updateSignupPage;
- (void)signedUp;

// account page
- (void)updateAccountPage;

// password page
- (void)changePasswordSubmitted:(id)sender;

@end
