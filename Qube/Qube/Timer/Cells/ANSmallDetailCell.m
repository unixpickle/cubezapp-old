//
//  ANSmallDetailCell.m
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSmallDetailCell.h"

@implementation ANSmallDetailCell

@synthesize nameLabel;

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    self = [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
    if (self) {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, self.contentView.frame.size.height)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    nameLabel.frame = CGRectMake(15, 0, nameLabel.frame.size.width, self.frame.size.height);
}

- (void)setCellValue:(id)aValue {
    [self doesNotRecognizeSelector:@selector(setCellValue:)];
}

@end
