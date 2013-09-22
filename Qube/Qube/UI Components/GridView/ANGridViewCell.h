//
//  ANGridViewCell.h
//  GridView
//
//  Created by Alex Nichol on 9/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGridViewItem.h"

@class ANGridViewCell;

@protocol ANGridViewCellDelegate

- (void)gridViewCellDeleted:(ANGridViewCell *)cell;

@end

@interface ANGridViewCell : UIView {
    ANGridViewItem * item;
    UIButton * deleteButton;
    BOOL dragging;
}

@property (readonly) ANGridViewItem * item;
@property (readwrite, getter = isDragging) BOOL dragging;
@property (readonly) UIButton * deleteButton;
@property (nonatomic, weak) id<ANGridViewCellDelegate> delegate;

- (id)initWithFrame:(CGRect)frame item:(ANGridViewItem *)item;

- (void)deleteButtonPressed:(id)sender;
- (void)setEditing:(BOOL)editing;

@end
