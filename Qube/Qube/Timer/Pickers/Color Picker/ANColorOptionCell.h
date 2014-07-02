//
//  ANColorOptionCell.h
//  Qube
//
//  Created by Alex Nichol on 9/25/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kANColorOptionCellPreviewColor 20

@interface ANColorOptionCell : UITableViewCell {
    UIView * colorPreview;
    UILabel * nameLabel;
}

@property (readonly) UIView * colorPreview;
@property (readonly) UILabel * nameLabel;

@end
