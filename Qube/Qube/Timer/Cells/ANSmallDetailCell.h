//
//  ANSmallDetailCell.h
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSmallDetailCell : UITableViewCell {
    UILabel * nameLabel;
}

@property (readonly) UILabel * nameLabel;

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier;
- (void)setCellValue:(id)aValue;

@end
