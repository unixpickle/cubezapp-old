//
//  ANAddPuzzleVC.h
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDataManager.h"
#import "ANPuzzle+Default.h"
#import "Color+HexValue.h"

#import "ANTextEntryCell.h"
#import "ANTextInfoCell.h"
#import "ANColorPickerCell.h"

#import "ANPuzzleTypePickerVC.h"
#import "ANColorPickerVC.h"

@class ANEditPuzzleVC;

@protocol ANEditPuzzleVCDelegate

- (void)editPuzzleVCCancelled:(ANEditPuzzleVC *)vc;
- (void)editPuzzleVCDone:(ANEditPuzzleVC *)vc;

@end

@interface ANEditPuzzleVC : UITableViewController <UITextFieldDelegate, ANPuzzleTypePickerVCDelegate, ANColorPickerVCDelegate> {
    UIBarButtonItem * doneButton;
    UIBarButtonItem * cancelButton;
    ANPuzzle * puzzle;
    
    UIImage * puzzleImage;
    UITextField * nameField;
}

@property (readonly) ANPuzzle * puzzle;
@property (nonatomic, weak) id<ANEditPuzzleVCDelegate> delegate;

- (id)initWithPuzzle:(ANPuzzle *)aPuzzle;

- (void)puzzleChanged:(id)sender;
- (void)donePressed:(id)sender;
- (void)cancelPressed:(id)sender;

@end
