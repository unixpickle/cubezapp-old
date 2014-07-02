//
//  ANImageCategoryCell.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImageCategoryCell.h"

@implementation ANImageCategoryCell

@synthesize imageContainer;
@synthesize categoryImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        
        [imageContainer addSubview:categoryImage];
        [self.contentView addSubview:imageContainer];
        
        imageContainer.layer.cornerRadius = 10;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor * bgColor = imageContainer.backgroundColor;
    [super setSelected:selected animated:animated];
    imageContainer.backgroundColor = bgColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor * bgColor = imageContainer.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    imageContainer.backgroundColor = bgColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    imageContainer.frame = CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10);
    categoryImage.frame = CGRectInset(imageContainer.bounds, 5, 5);
    self.textLabel.frame = CGRectMake(self.frame.size.height, (self.frame.size.height - self.textLabel.frame.size.height) / 2,
                                      self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetMaxX(imageContainer.frame) + 3, 0, 0);
}

@end
