//
//  ANTimerHomeVC.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDataManager+Utility.h"

#import "ANPuzzleGrid.h"
#import "ANPuzzleFrontView.h"
#import "ANPuzzleBackView.h"

#import "ANEditPuzzleVC.h"
#import "ANTimerFlowVC.h"
#import "ANControlledNavController.h"

@interface ANTimerHomeVC : UIViewController <ANGridViewDelegate, ANPuzzleGridDelegate, ANEditPuzzleVCDelegate, UIAlertViewDelegate> {
    UIBarButtonItem * accountButton;
    UIBarButtonItem * addButton;
    UIBarButtonItem * doneButton;
    
    ANPuzzleGrid * gridView;
    
    ANPuzzle * deletingPuzzle;
}

@property (readonly) UIBarButtonItem * accountButton;
@property (readonly) ANPuzzleGrid * gridView;
@property (nonatomic, weak) ANEditPuzzleVC * editVC;

- (void)syncUpdatedPuzzle:(ANPuzzle *)puzzle;
- (void)syncAddedPuzzle:(ANPuzzle *)puzzle;
- (void)syncDeletedPuzzle:(ANPuzzle *)puzzle;

- (void)accountPressed:(id)sender;
- (void)addPressed:(id)sender;
- (void)donePressed:(id)sender;

- (void)showEditDialog:(ANPuzzle *)puzzle;

@end
