//
//  ANColorPickerCell.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANColorPickerCell.h"

@implementation ANColorPickerCell

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithNameWidth:width reuseIdentifier:identifier])) {
        sampleView = [[UIView alloc] initWithFrame:CGRectMake(100, 5, self.contentView.frame.size.height - 10,
                                                              self.contentView.frame.size.height - 10)];
        [self.contentView addSubview:sampleView];
        
        sampleView.layer.cornerRadius = sampleView.frame.size.height / 2;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat sampleSize = self.contentView.frame.size.height - 10;
    sampleView.frame = CGRectMake(self.frame.size.width - sampleSize - 40, 5, sampleSize, sampleSize);
    sampleView.layer.cornerRadius = sampleView.frame.size.height / 2;
}

- (void)setCellValue:(id)aValue {
    NSAssert([aValue isKindOfClass:[UIColor class]], @"Invalid cell value class.");
    sampleView.backgroundColor = aValue;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor * bg = sampleView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    sampleView.backgroundColor = bg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor * bg = sampleView.backgroundColor;
    [super setSelected:selected animated:animated];
    sampleView.backgroundColor = bg;
}

@end
