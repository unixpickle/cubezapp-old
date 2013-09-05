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
#import "ANLoadingOverlay.h"
#import "ANSlideTransitionalView.h"
#import "ANFadeTransitionalView.h"

@interface ANAccountSettingsVC : UIViewController <UIAlertViewDelegate> {
    UIButton * backButton;
    
    ANSigninView * signinView;
    ANSignupView * signupView;
    ANSlideTransitionalView * transitionalView;
        
    UIButton * signupButton;
    UIButton * cancelButton;
    ANFadeTransitionalView * buttonTransition;
}

- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;

- (void)signupPressed:(id)sender;
- (void)cancelSignupPressed:(id)sender;

- (void)loggedIn;
- (void)backPressed:(id)sender;

- (void)handleSigninFailed:(NSError *)error;
- (void)handleSignedIn;

@end
