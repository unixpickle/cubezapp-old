//
//  ANTextEntryCell.m
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTextEntryCell.h"

@implementation ANTextEntryCell

@synthesize textField;

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithNameWidth:width reuseIdentifier:identifier])) {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, self.contentView.frame.size.height)];
        [self.contentView addSubview:textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width - CGRectGetMaxX(self.nameLabel.frame) - 20;
    textField.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 10,
                                 0, width, self.contentView.frame.size.height);
}

- (void)setCellValue:(id)aValue {
    NSAssert([aValue isKindOfClass:[NSString class]], @"Invalid cell value class.");
    textField.text = aValue;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
