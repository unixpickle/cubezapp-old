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
        sampleView = [[UIView alloc] initWithFrame:CGRectMake(100, 5, 60, self.contentView.frame.size.height - 10)];
        [self.contentView addSubview:sampleView];
        
        sampleView.layer.borderWidth = 1;
        sampleView.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    sampleView.frame = CGRectMake(self.frame.size.width - 90, 5, 60, self.contentView.frame.size.height - 10);
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
