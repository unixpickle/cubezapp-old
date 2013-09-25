//
//  ANPuzzleBackView.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridViewItem.h"

@interface ANPuzzleBackView : UIView {
    UIButton * infoButton, * statButton;
}

@property (readonly) UIButton * infoButton;
@property (readonly) UIButton * statButton;
@property (nonatomic, weak) id puzzle;

@end
