//
//  ANAppDelegate.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANAPICallSignup.h"
#import "ANViewController.h"

#import "NSSetOrderedSetFix.h"

@interface ANAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ANViewController *viewController;

@end
