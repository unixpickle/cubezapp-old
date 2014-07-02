//
//  ANImagePickerMenuVC.h
//  Qube
//
//  Created by Alex Nichol on 9/27/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPuzzlePhotoCategory.h"
#import "ANImageCategoryCell.h"
#import "ANImagePickerGridVC.h"
#import "UIImage+FixOrientation.h"
#import "UIImage+ANImageBitmapRep.h"

@interface ANImagePickerMenuVC : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSArray * categories;
    UIColor * puzzleColor;
}

@property (nonatomic, retain) UIColor * puzzleColor;
@property (nonatomic, weak) id<ANImagePickerDelegate> delegate;

@end
