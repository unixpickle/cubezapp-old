//
//  ANTimerHomeVC.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANTimerHomeVC : UIViewController {
    UIBarButtonItem * accountButton;
    UIBarButtonItem * addButton;
}

@property (readonly) UIBarButtonItem * accountButton;

- (void)accountPressed:(id)sender;
- (void)addPressed:(id)sender;

@end
