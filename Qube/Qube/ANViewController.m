//
//  ANViewController.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANViewController.h"

@interface ANViewController ()


@end

@implementation ANViewController

@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[ANAccountManager sharedAccountManager] setDelegate:self];
    [[ANSyncManager sharedSyncManager] setDelegate:self];
    
    self.tabBar.barStyle = UIBarStyleDefault;
    self.view.backgroundColor = [UIColor blackColor];
    
    // generate a navigation controller for each page
    algorithms = [[ANAlgorithmsHomeVC alloc] init];
    timer = [[ANTimerHomeVC alloc] init];
    settings = [[ANDesignHomeVC alloc] init];
    NSArray * contents = @[algorithms, timer, settings];
    NSMutableArray * vcs = [NSMutableArray array];
    for (UIViewController * vc in contents) {
        UINavigationController * nvc = [[UINavigationController alloc] init];
        [nvc pushViewController:vc animated:NO];
        nvc.tabBarItem = vc.tabBarItem;
        [vcs addObject:nvc];
        
        nvc.navigationBar.barStyle = UIBarStyleDefault;
    }
    self.viewControllers = vcs;
    
    accountSettings = [[ANAccountSettingsVC alloc] init];
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [accountSettings setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self updateAccountButton];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)flipToAccountsSettings {
    [self presentViewController:accountSettings
                       animated:YES
                     completion:nil];
}

- (void)updateAccountButton {
    if ([ANDataManager sharedDataManager].activeAccount.username == nil) {
        timer.accountButton.title = @"Login";
    } else {
        NSString * usernameStr = [ANDataManager sharedDataManager].activeAccount.name;
        UIFont * font = [UIFont systemFontOfSize:16];
        BOOL didTruncate = NO;
        while ([[usernameStr stringByAppendingString:didTruncate ? @"" : @"..."] sizeWithFont:font].width > 100) {
            didTruncate = YES;
            usernameStr = [usernameStr substringWithRange:NSMakeRange(0, usernameStr.length - 1)];
        }
        if (didTruncate) usernameStr = [usernameStr stringByAppendingString:@"..."];
        timer.accountButton.title = usernameStr;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accounts -

- (void)accountManagerLoggedIn:(ANAccountManager *)manager {
    [accountSettings handleSignedIn];
    [self updateAccountButton];
}

- (void)accountManager:(ANAccountManager *)manager loginFailed:(NSError *)error {
    [accountSettings handleSigninFailed:error];
}

- (void)accountManagerUserLoggedOut:(ANAccountManager *)manager {
    timer.accountButton.title = @"Login";
}

#pragma mark - Sync -

- (void)syncManagerStarted:(ANSyncManager *)manager {
    [accountSettings.accountView.syncView.loadingKnob startLoading];
    [accountSettings.accountView.syncView setStatus:@"Syncing"];
}

- (void)syncManagerCancelled:(ANSyncManager *)manager {
    [accountSettings.accountView.syncView.loadingKnob stopLoading];
    [accountSettings.accountView.syncView setStatus:@"Not currently syncing"];
}

#pragma mark Sync Session

- (void)syncSession:(ANSyncSession *)session addedPuzzle:(ANPuzzle *)puzzle {
    [timer syncAddedPuzzle:puzzle];
}

- (void)syncSession:(ANSyncSession *)session deletedPuzzle:(ANPuzzle *)puzzle {
    [timer syncDeletedPuzzle:puzzle];
}

- (void)syncSession:(ANSyncSession *)session updatedPuzzle:(ANPuzzle *)puzzle {
    [timer syncUpdatedPuzzle:puzzle];
}

- (void)syncSession:(ANSyncSession *)session addedSession:(ANSession *)puzzle {
    
}

- (void)syncSession:(ANSyncSession *)session deletedSession:(ANSession *)aSession {
    
}

- (void)syncSession:(ANSyncSession *)session updatedAccount:(LocalAccount *)account {
    
}

- (void)syncSession:(ANSyncSession *)session failedWithError:(NSError *)error {
    [accountSettings.accountView.syncView.loadingKnob stopLoading];
    [accountSettings.accountView.syncView setFailed:@"Last sync failed"];
}

- (void)syncSessionCompleted:(ANSyncSession *)session {
    [accountSettings.accountView.syncView.loadingKnob stopLoading];
    [accountSettings.accountView.syncView setStatus:@"Not currently syncing"];
}

@end
