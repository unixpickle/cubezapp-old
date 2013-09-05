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

CGFloat PENISHEIGHT(UIView * view);

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ANAccountManager sharedAccountManager] setDelegate:self];
    [[ANSyncManager sharedSyncManager] setDelegate:self];
    
    self.tabBar.barStyle = UIBarStyleBlack;
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
        
        nvc.navigationBar.barStyle = UIBarStyleBlack;
    }
    self.viewControllers = vcs;
    
    if ([ANDataManager sharedDataManager].activeAccount.username == nil) {
        timer.accountButton.title = @"Login";
    } else {
        timer.accountButton.title = [ANDataManager sharedDataManager].activeAccount.username;
    }
    
    accountSettings = [[ANAccountSettingsVC alloc] init];
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [accountSettings setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
}

- (void)flipToAccountsSettings {
    [self presentViewController:accountSettings
                       animated:YES
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accounts -

- (void)accountManagerLoggedIn:(ANAccountManager *)manager {
    [accountSettings handleSignedIn];
}

- (void)accountManager:(ANAccountManager *)manager loginFailed:(NSError *)error {
    [accountSettings handleSigninFailed:error];
}

#pragma mark - Sync -

- (void)syncManagerStarted:(ANSyncManager *)manager {
    
}

- (void)syncManagerCancelled:(ANSyncManager *)manager {
    
}

#pragma mark Sync Session

- (void)syncSession:(ANSyncSession *)session addedPuzzle:(ANPuzzle *)puzzle {
    
}

- (void)syncSession:(ANSyncSession *)session deletedPuzzle:(ANPuzzle *)puzzle {
    
}

- (void)syncSession:(ANSyncSession *)session updatedPuzzle:(ANPuzzle *)puzzle {
    
}

- (void)syncSession:(ANSyncSession *)session addedSession:(ANSession *)puzzle {
    
}

- (void)syncSession:(ANSyncSession *)session deletedSession:(ANSession *)aSession {
    
}

- (void)syncSession:(ANSyncSession *)session updatedAccount:(LocalAccount *)account {
    
}

- (void)syncSession:(ANSyncSession *)session failedWithError:(NSError *)error {
    
}

- (void)syncSessionCompleted:(ANSyncSession *)session {
    
}

@end
