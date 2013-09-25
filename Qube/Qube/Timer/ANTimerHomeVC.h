//
//  ANTimerHomeVC.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPuzzleGrid.h"
#import "ANEditPuzzleVC.h"
#import "ANPuzzleFrontView.h"
#import "ANPuzzleBackView.h"

@interface ANTimerHomeVC : UIViewController <ANGridViewDelegate, ANPuzzleGridDelegate, ANEditPuzzleVCDelegate, UIAlertViewDelegate> {
    UIBarButtonItem * accountButton;
    UIBarButtonItem * addButton;
    UIBarButtonItem * doneButton;
    
    ANPuzzleGrid * gridView;
    BOOL isAdding;
    
    ANPuzzle * deletingPuzzle;
}

@property (readonly) UIBarButtonItem * accountButton;
@property (readonly) ANPuzzleGrid * gridView;

- (void)accountPressed:(id)sender;
- (void)addPressed:(id)sender;
- (void)donePressed:(id)sender;

@end
