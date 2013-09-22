//
//  ANPuzzleTypePickerVC.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANConstants.h"

@class ANPuzzleTypePickerVC;

@protocol ANPuzzleTypePickerVCDelegate

- (void)puzzleTypePicker:(ANPuzzleTypePickerVC *)picker selected:(ANPuzzleType)type;

@end

@interface ANPuzzleTypePickerVC : UITableViewController {
    NSArray * names;
    NSInteger selectedName;
}

@property (nonatomic, weak) id<ANPuzzleTypePickerVCDelegate> delegate;

- (id)initWithSelected:(ANPuzzleType)type;

@end
