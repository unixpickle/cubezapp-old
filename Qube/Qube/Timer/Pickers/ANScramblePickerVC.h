//
//  ANScramblePickerVC.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPuzzleScrambler.h"

@class ANScramblePickerVC;

@protocol ANScramblePickerVCDelegate

- (void)scramblePicker:(ANScramblePickerVC *)picker picked:(NSString *)name;

@end

@interface ANScramblePickerVC : UITableViewController {
    NSArray * scramblerNames;
    NSString * currentName;
}

@property (nonatomic, weak) id<ANScramblePickerVCDelegate> delegate;

- (id)initWithScramblerNames:(NSArray *)names currentName:(NSString *)name;

@end
