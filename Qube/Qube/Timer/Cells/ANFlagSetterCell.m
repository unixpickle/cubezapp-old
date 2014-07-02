//
//  ANFlagSetterCell.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANFlagSetterCell.h"

@implementation ANFlagSetterCell

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    self = [super initWithNameWidth:width reuseIdentifier:identifier];
    if (self) {
        valueSwitch = [[UISwitch alloc] init];
        valueSwitch.on = NO;
        [valueSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:valueSwitch];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    valueSwitch.frame = CGRectMake(self.frame.size.width - valueSwitch.frame.size.width - 10,
                                   (self.frame.size.height - valueSwitch.frame.size.height) / 2,
                                   valueSwitch.frame.size.width, valueSwitch.frame.size.height);
}

- (void)setCellValue:(id)aValue {
    valueSwitch.on = [aValue boolValue];
}

- (void)switchChanged:(id)sender {
    [self.delegate flagSetterCell:self switched:valueSwitch.on];
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
