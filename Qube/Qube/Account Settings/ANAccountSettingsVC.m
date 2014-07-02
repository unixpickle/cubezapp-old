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

- (void)createContent;
- (void)registerEvents;
- (void)createUsernameLabel;

@end

@implementation ANAccountSettingsVC

@synthesize accountView;

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (id)init {
    self = [super init];
    if (self) {
        // create the backdrop
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = [UIImage imageNamed:@"account_bg"];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.contentScaleFactor = 1.6;
        [self.view addSubview:imageView];
        
        // create the back button
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 40, 40)];
        [backButton setImage:[UIImage imageNamed:@"back"]
                    forState:UIControlStateNormal];
        [backButton addTarget:self
                       action:@selector(backPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        
        // create the content pages
        [self createContent];
        [self createUsernameLabel];
        [self registerEvents];
        
        // setup the content pages
        if (![[ANAccountManager sharedAccountManager] isSignedOut]) {
            [self updateAccountPage];
            [self jumpToPage:accountView];
        } else {
            [self jumpToPage:signinView];
        }
    }
    return self;
}

- (void)presentPage:(UIView<ANAccountPage> *)page forward:(BOOL)forward {
    if (forward) {
        [transitionalView pushToView:page];
    } else {
        [transitionalView popToView:page];
    }
    [buttonTransition transitionTo:page.button];
    if ([[ANAccountManager sharedAccountManager] isSignedOut]) {
        [usernameContainer transitionTo:nil];
    } else {
        [usernameContainer transitionTo:usernameLabel];
    }
}

- (void)jumpToPage:(UIView<ANAccountPage> *)page {
    [transitionalView changeView:page];
    [buttonTransition changeView:page.button];
    if ([[ANAccountManager sharedAccountManager] isSignedOut]) {
        [usernameContainer changeView:nil];
    } else {
        [usernameContainer changeView:usernameLabel];
    }
}

- (void)createContent {
    CGFloat viewHeight = self.view.frame.size.height - kTopSpacing - kBottomSpacing;
    signinView = [[ANSigninView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    
    transitionalView = [[ANSlideTransitionalView alloc] initWithFrame:CGRectMake(0, kTopSpacing,
                                                                                 self.view.frame.size.width,
                                                                                 viewHeight)];
    signinView.target = self;
    signinView.action = @selector(loggedIn);
    
    [self.view addSubview:transitionalView];
    
    signupView = [[ANSignupView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    signupView.target = self;
    signupView.action = @selector(signedUp);
    
    accountView = [[ANAccountView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    accountView.delegate = self;
    
    passwordView = [[ANChangePasswordView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    
    buttonTransition = [[ANFadeTransitionalView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100,
                                                                                self.view.frame.size.height - 77, 200, 67)];
    [self.view addSubview:buttonTransition];
}

- (void)createUsernameLabel {
    usernameLabel = [[UILabel alloc] init];
    CGFloat width = self.view.frame.size.width - CGRectGetMaxX(backButton.frame) - 40;
    usernameContainer = [[ANFadeTransitionalView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backButton.frame) + 10,
                                                                                 backButton.frame.origin.y, width,
                                                                                 backButton.frame.size.height)];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.font = [UIFont boldSystemFontOfSize:30];
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:usernameContainer];
}

- (void)registerEvents {
    [accountView.button addTarget:self action:@selector(logoutPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    [signinView.button addTarget:self action:@selector(signupPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    [signupView.button addTarget:self action:@selector(cancelSignupPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    [passwordView.button addTarget:self action:@selector(cancelPasswordPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
    [passwordView.changeButton addTarget:self action:@selector(changePasswordSubmitted:)
                        forControlEvents:UIControlEventTouchUpInside];
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
    CGRect activeFrame = CGRectMake(0, kTopSpacing, self.view.frame.size.width, self.view.frame.size.height - height - kTopSpacing);
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
    CGRect activeFrame = CGRectMake(0, kTopSpacing, self.view.frame.size.width,
                                    self.view.frame.size.height - kTopSpacing - kBottomSpacing);
    NSNumber * duration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         transitionalView.frame = activeFrame;
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Buttons -

- (void)signupPressed:(id)sender {
    [self updateSignupPage];
    [self presentPage:signupView forward:YES];
}

- (void)cancelSignupPressed:(id)sender {
    [self updateSigninPage];
    [self presentPage:signinView forward:NO];
}

- (void)logoutPressed:(id)sender {
    [[ANAccountManager sharedAccountManager] logout];
    [self presentPage:signinView forward:NO];
}

- (void)cancelPasswordPressed:(id)sender {
    [self presentPage:accountView forward:NO];
    [accountView.passwordButton deselect:YES];
}

- (void)backPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Signup -

- (void)signedUp {
    NSData * hash = [[signupView.passwordField.text dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
    ANAPICallSignup * signup = [[ANAPICallSignup alloc] initWithUsername:signupView.usernameField.text
                                                                    hash:hash
                                                                   email:signupView.emailField.text
                                                                  scheme:[[ANCubeScheme alloc] init]
                                                                    name:signupView.nameField.text];
    [signup fetchResponse:^(NSError * error, NSDictionary * obj) {
        if (error) {
            [[ANLoadingOverlay sharedOverlay] hideOverlay];
            UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Signup Failed"
                                                          message:[error localizedDescription]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil];
            [av show];
        } else {
            NSLog(@"response: %@", obj);
            // make it look like we're trying to login!
            signinView.usernameField.text = signupView.usernameField.text;
            signinView.passwordField.text = signupView.passwordField.text;
            [self loggedIn];
        }
    }];
    [[ANLoadingOverlay sharedOverlay] displayOverlay];
}

- (void)updateSignupPage {
    signupView.usernameField.text = @"";
    signupView.passwordField.text = @"";
    signupView.confirmField.text = @"";
    signupView.nameField.text = @"";
    signupView.emailField.text = @"";
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

- (void)updateSigninPage {
    signinView.usernameField.text = @"";
    signinView.passwordField.text = @"";
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
    [self presentPage:accountView forward:YES];
    [self updateAccountPage];
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

#pragma mark - Active Account -

- (void)updateAccountPage {
    accountView.nameField.text = [ANDataManager sharedDataManager].activeAccount.name;
    accountView.emailField.text = [ANDataManager sharedDataManager].activeAccount.email;
    usernameLabel.text = [ANDataManager sharedDataManager].activeAccount.username;
    accountView.syncView.autosyncSwitch.on = [ANSyncManager sharedSyncManager].autosync;
}

#pragma mark Delegate

- (void)accountView:(ANAccountView *)_accountView emailSet:(NSString *)email {
    [[ANLoadingOverlay sharedOverlay] displayOverlay];
    ANAPICall * call = [[ANAPICallAccountSetEmail alloc] initWithEmail:email];
    [call fetchResponse:^(NSError * error, NSDictionary * obj) {
        [[ANLoadingOverlay sharedOverlay] hideOverlay];
        if (error) {
            UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:[error localizedDescription]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil];
            [av show];
            accountView.emailField.text = [ANDataManager sharedDataManager].activeAccount.email;
        } else {
            [ANDataManager sharedDataManager].activeAccount.email = email;
        }
    }];
}

- (void)accountView:(ANAccountView *)accountView nameSet:(NSString *)newName {
    [[ANDataManager sharedDataManager].activeAccount offlineSetName:newName];
    
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController updateAccountButton];
}

- (void)accountViewPasswordPressed:(ANAccountView *)accountView {
    [self presentPage:passwordView forward:YES];
}

- (void)accountView:(ANAccountView *)accountView autosyncSet:(BOOL)flag {
    [[ANSyncManager sharedSyncManager] setAutosync:flag];
}

- (void)accountViewSyncPressed:(ANAccountView *)accountView {
    [[ANSyncManager sharedSyncManager] startSyncing];
}

#pragma mark - Password Page -

- (void)changePasswordSubmitted:(id)sender {
    // here we will do our nice logic
    if (![passwordView.passwordField.text isEqualToString:passwordView.confirmPasswordField.text]) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Password Mismatch"
                                                      message:@"The entered passwords do not match"
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK", nil];
        [av show];
        return;
    }
    [[ANLoadingOverlay sharedOverlay] displayOverlay];
    ANAPICallAccountSetHash * call = [[ANAPICallAccountSetHash alloc] initWithOldPassword:passwordView.oldPasswordField.text
                                                                              newPassword:passwordView.passwordField.text];
    [call fetchResponse:^(NSError * error, NSDictionary * obj) {
        [[ANLoadingOverlay sharedOverlay] hideOverlay];
        if (error) {
            UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:[error localizedDescription]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil];
            [av show];
        } else {
            NSData * newHash = [[passwordView.passwordField.text dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
            [ANDataManager sharedDataManager].activeAccount.passwordmd5 = newHash;
            [self cancelPasswordPressed:nil];
        }
    }];
}

@end
