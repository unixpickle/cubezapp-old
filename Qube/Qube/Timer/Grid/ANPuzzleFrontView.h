//
//  ANPuzzleFrontView.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridViewItem.h"
#import "ANPuzzle.h"

#import "ANImageManager.h"
#import "Color+HexValue.h"

@interface ANPuzzleFrontView : UIControl {
    UIImageView * puzzleImage;
    UILabel * puzzleLabel;
}

@property (readonly) UIImageView * puzzleImage;
@property (readonly) UILabel * puzzleLabel;
@property (nonatomic, weak) id puzzle;

- (void)updateWithPuzzle:(ANPuzzle *)puzzle;

@end
