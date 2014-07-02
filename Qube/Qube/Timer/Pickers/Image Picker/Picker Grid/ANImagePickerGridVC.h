//
//  ANImagePickerGridVC.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANImageOptionButton.h"
#import "ANImagePickerDelegate.h"

#define kANImagePickerGridRowSize 2
#define kANImagePickerGridSpacing 10

@interface ANImagePickerGridVC : UIViewController {
    UIScrollView * scrollView;
    NSArray * imageNames;
    NSMutableArray * imageCells;
    NSInteger imagesLoaded;
}

@property (nonatomic, weak) id<ANImagePickerDelegate> delegate;

- (id)initWithImageNames:(NSArray *)names puzzleColor:(UIColor *)color;

@end
