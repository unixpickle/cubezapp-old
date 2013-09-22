//
//  ANTextInfoCell.m
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTextInfoCell.h"

@implementation ANTextInfoCell

@synthesize infoLabel;

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithNameWidth:width reuseIdentifier:identifier])) {
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.contentView.frame.size.height)];
        infoLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:infoLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width - CGRectGetMaxX(self.nameLabel.frame) - 20;
    infoLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 10,
                                 0, width, self.contentView.frame.size.height);
}

- (void)setCellValue:(id)aValue {
    NSAssert([aValue isKindOfClass:[NSString class]], @"Invalid cell value class.");
    infoLabel.text = aValue;
}

@end
