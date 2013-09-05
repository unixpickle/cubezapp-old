//
//  ANViewController.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANAccountManager.h"
#import "ANSyncManager.h"

#import "ANAlgorithmsHomeVC.h"
#import "ANTimerHomeVC.h"
#import "ANDesignHomeVC.h"
#import "ANAccountSettingsVC.h"

@interface ANViewController : UITabBarController <ANAccountManagerDelegate, ANSyncManagerDelegate> {
    ANAlgorithmsHomeVC * algorithms;
    ANTimerHomeVC * timer;
    ANDesignHomeVC * settings;
    ANAccountSettingsVC * accountSettings;
}

- (void)flipToAccountsSettings;

@end
