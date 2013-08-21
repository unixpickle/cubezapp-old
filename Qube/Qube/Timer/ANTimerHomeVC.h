//
//  ANTimerHomeVC.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANTimerHomeVC : UIViewController {
    UIBarButtonItem * editButton;
    UIBarButtonItem * doneButton;
    UIBarButtonItem * addButton;
}

- (void)editPressed:(id)sender;
- (void)donePressed:(id)sender;
- (void)addPressed:(id)sender;

@end
