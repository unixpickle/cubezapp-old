//
//  ANColorPickerVC.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANColorOptionCell.h"

@class ANColorPickerVC;

@protocol ANColorPickerVCDelegate

- (void)colorPicker:(ANColorPickerVC *)picker pickedColor:(UIColor *)color;

@end

@interface ANColorPickerVC : UITableViewController {
    NSInteger initialIndex;
    NSArray * colors;
}

@property (nonatomic, weak) id<ANColorPickerVCDelegate> delegate;

- (id)initWithColor:(UIColor *)initialColor;

@end
