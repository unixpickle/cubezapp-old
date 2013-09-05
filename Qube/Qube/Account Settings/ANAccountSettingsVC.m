//
//  ANAccountSettingsVC.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountSettingsVC.h"
#import "ANAppDelegate.h"

@interface ANAccountSettingsVC ()

- (void)createButtons;

@end

@implementation ANAccountSettingsVC

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (id)init {
    self = [super init];
    if (self) {        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = [UIImage imageNamed:@"account_bg"];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.contentScaleFactor = 1.6;
        [self.view addSubview:imageView];
        
        signinView = [[ANSigninView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        
        transitionalView = [[ANSlideTransitionalView alloc] initWithFrame:CGRectMake(0, 83, self.view.frame.size.width,
                                                                                self.view.frame.size.height - 200)
                                                                view:signinView];
        signinView.target = self;
        signinView.action = @selector(loggedIn);
        
        [self.view addSubview:transitionalView];
        
        signupView = [[ANSignupView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        [self createButtons];
    }
    return self;
}

- (void)createButtons {
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 57, 57)];
    [backButton setImage:[UIImage imageNamed:@"back"]
                forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backPressed:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backButton];
    
    signupButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100,
                                                              self.view.frame.size.height - 77, 200, 67)];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [signupButton setTitle:@"Sign Up!" forState:UIControlStateNormal];
    [signupButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:20]];
    [signupButton addTarget:self action:@selector(signupPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    buttonTransition = [[ANFadeTransitionalView alloc] initWithFrame:signupButton.frame
                                                                view:signupButton];
    [self.view addSubview:buttonTransition];
    
    cancelButton = [[UIButton alloc] initWithFrame:signupButton.bounds];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:signupButton.titleLabel.font];
    [cancelButton addTarget:self action:@selector(cancelSignupPressed:)
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)backPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Events -

- (void)viewWillAppear:(BOOL)animated {
    [signinView.banner startAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [signinView.banner stopAnimating];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary * info = notification.userInfo;
    CGFloat height = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGRect activeFrame = CGRectMake(0, 83, self.view.frame.size.width, self.view.frame.size.height - height - 83);
    NSNumber * duration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         transitionalView.frame = activeFrame;
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    CGRect activeFrame = CGRectMake(0, 83, self.view.frame.size.width, self.view.frame.size.height - 200);
    NSNumber * duration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         transitionalView.frame = activeFrame;
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Signup -

- (void)signupPressed:(id)sender {
    [transitionalView pushToView:signupView];
    [buttonTransition transitionTo:cancelButton];
}

- (void)cancelSignupPressed:(id)sender {
    [transitionalView popToView:signinView];
    [buttonTransition transitionTo:signupButton];
}

#pragma mark - Signin -

- (void)loggedIn {
    [[ANLoadingOverlay sharedOverlay] displayOverlay];
    ANAccountManager * manager = [ANAccountManager sharedAccountManager];
    if ([manager shouldAllowKeepingData:signinView.usernameField.text]) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Keep offline content"
                                                      message:@"While you were not logged in, you made modifications to your cubing data. Would you like to sync this data when you log in?"
                                                     delegate:self
                                            cancelButtonTitle:@"Lose Data"
                                            otherButtonTitles:@"Sync Data", nil];
        [av show];
    } else {
        [manager loginWithUsername:signinView.usernameField.text
                          password:signinView.passwordField.text
                       keepingData:NO];
    }
}

#pragma mark Events

- (void)handleSigninFailed:(NSError *)error {
    [[ANLoadingOverlay sharedOverlay] hideOverlay];
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Signin Error"
                                                  message:[error localizedDescription]
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"OK", nil];
    [av show];
}

- (void)handleSignedIn {
    [[ANLoadingOverlay sharedOverlay] hideOverlay];
}

#pragma mark Alert View

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ANAccountManager * manager = [ANAccountManager sharedAccountManager];
    BOOL flag = NO;
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Sync Data"]) {
        flag = YES;
    }
    [manager loginWithUsername:signinView.usernameField.text
                      password:signinView.passwordField.text
                   keepingData:flag];
}

@end
