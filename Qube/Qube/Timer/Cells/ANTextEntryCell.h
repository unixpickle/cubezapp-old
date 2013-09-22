//
//  ANTextEntryCell.h
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSmallDetailCell.h"

@interface ANTextEntryCell : ANSmallDetailCell {
    UITextField * textField;
}

@property (readonly) UITextField * textField;

@end
