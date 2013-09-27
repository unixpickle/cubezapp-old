//
//  ANColorOptionCell.m
//  Qube
//
//  Created by Alex Nichol on 9/25/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANColorOptionCell.h"

@implementation ANColorOptionCell

@synthesize colorPreview;
@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        colorPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kANColorOptionCellPreviewColor, kANColorOptionCellPreviewColor)];
        colorPreview.layer.cornerRadius = colorPreview.frame.size.height / 2;
        [self.contentView addSubview:colorPreview];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.contentView.frame.size.height)];
        [self.contentView addSubview:nameLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor * color = colorPreview.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    colorPreview.backgroundColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor * color = colorPreview.backgroundColor;
    [super setSelected:selected animated:animated];
    colorPreview.backgroundColor = color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    colorPreview.frame = CGRectMake((50 - kANColorOptionCellPreviewColor) / 2,
                                    (self.frame.size.height - kANColorOptionCellPreviewColor) / 2,
                                    kANColorOptionCellPreviewColor, kANColorOptionCellPreviewColor);
    nameLabel.frame = CGRectMake(50, 0, self.frame.size.width - 5, self.frame.size.height);
}

@end
