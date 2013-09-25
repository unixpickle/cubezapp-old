//
//  ANPuzzleFrontView.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridViewItem.h"

@interface ANPuzzleFrontView : UIView {
    UIImageView * puzzleImage;
    UILabel * puzzleLabel;
}

@property (readonly) UIImageView * puzzleImage;
@property (readonly) UILabel * puzzleLabel;

@end
