//
//  ANPuzzleFrontView.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleFrontView.h"

@implementation ANPuzzleFrontView

@synthesize puzzleImage;
@synthesize puzzleLabel;

- (id)init {
    self = [super init];
    if (self) {
        puzzleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        puzzleImage.layer.cornerRadius = 5;
        puzzleImage.contentMode = UIViewContentModeScaleAspectFit;
        puzzleImage.backgroundColor = [UIColor clearColor];
        [self addSubview:puzzleImage];
        
        puzzleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        puzzleLabel.backgroundColor = [UIColor clearColor];
        puzzleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:puzzleLabel];

        self.layer.cornerRadius = 10;
        self.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1] CGColor];
        self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageSize = self.frame.size.height - 40;
    puzzleImage.frame = CGRectMake(20, 5, imageSize, imageSize);
    puzzleLabel.frame = CGRectMake(5, self.frame.size.height - 30, self.frame.size.width - 10,
                                   25);
}
//
//- (void)setBackgroundColor:(UIColor *)backgroundColor {
//    [super setBackgroundColor:[UIColor whiteColor]];
//}

@end
