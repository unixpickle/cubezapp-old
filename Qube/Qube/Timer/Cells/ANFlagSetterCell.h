//
//  ANFlagSetterCell.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSmallDetailCell.h"

@class ANFlagSetterCell;

@protocol ANFlagSetterCellDelegate

- (void)flagSetterCell:(ANFlagSetterCell *)cell switched:(BOOL)on;

@end

@interface ANFlagSetterCell : ANSmallDetailCell {
    UISwitch * valueSwitch;
}

@property (nonatomic, weak) id<ANFlagSetterCellDelegate> delegate;

- (void)switchChanged:(id)sender;

@end
