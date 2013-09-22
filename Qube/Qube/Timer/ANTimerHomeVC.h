//
//  ANTimerHomeVC.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridView.h"
#import "ANEditPuzzleVC.h"

@interface ANTimerHomeVC : UIViewController <ANGridViewDelegate, ANEditPuzzleVCDelegate> {
    UIBarButtonItem * accountButton;
    UIBarButtonItem * addButton;
    
    ANGridView * gridView;
    BOOL isAdding;
}

@property (readonly) UIBarButtonItem * accountButton;
@property (readonly) ANGridView * gridView;

- (void)accountPressed:(id)sender;
- (void)addPressed:(id)sender;

@end
