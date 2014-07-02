//
//  ANTimePickerCell.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimePickerCell.h"

@implementation ANTimePickerCell

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithNameWidth:width reuseIdentifier:identifier])) {
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    timeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 0, self.contentView.frame.size.width - CGRectGetMaxX(nameLabel.frame) - 20,
                                 self.frame.size.height);
}

- (void)setCellValue:(id)aValue {
    NSTimeInterval time = [aValue doubleValue];
    int rounded = round(time);
    timeLabel.text = [NSString stringWithFormat:@"%d seconds", rounded];
}

@end
