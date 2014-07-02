//
//  ANImagePicker.m
//  Qube
//
//  Created by Alex Nichol on 9/27/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImagePickerCell.h"

@implementation ANImagePickerCell

- (id)initWithNameWidth:(CGFloat)width reuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithNameWidth:width reuseIdentifier:identifier])) {
        [nameLabel removeFromSuperview];
        sticker = [[ANPuzzleFrontView alloc] init];
        sticker.userInteractionEnabled = NO;
        [self.contentView addSubview:sticker];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat stickerSize = self.frame.size.height - 10;
    sticker.frame = CGRectMake((self.frame.size.width - stickerSize) / 2,
                               5, stickerSize, stickerSize);
}

- (void)setCellValue:(id)aValue {
    UIColor * bgColor = aValue[@"color"];
    NSString * name = aValue[@"name"];
    UIImage * image = aValue[@"image"];
    sticker.backgroundColor = bgColor;
    sticker.puzzleImage.image = image;
    sticker.puzzleLabel.text = name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor * bgColor = sticker.backgroundColor;
    [super setSelected:selected animated:animated];
    sticker.backgroundColor = bgColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor * bgColor = sticker.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    sticker.backgroundColor = bgColor;
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
