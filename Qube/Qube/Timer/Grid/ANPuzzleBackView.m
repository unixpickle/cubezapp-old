//
//  ANPuzzleBackView.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleBackView.h"

@implementation ANPuzzleBackView

@synthesize infoButton, statButton;
@synthesize puzzle;

- (id)init {
    self = [super init];
    if (self) {
        overlayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"texture"]];
        overlayImage.alpha = 0.3;
        [self addSubview:overlayImage];
        
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1] CGColor];
        self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        
        self.backgroundColor = [UIColor whiteColor];
        infoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        statButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [infoButton setTitle:@"Info" forState:UIControlStateNormal];
        [statButton setTitle:@"Stats" forState:UIControlStateNormal];
        
        [infoButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [statButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [self addSubview:infoButton];
        [self addSubview:statButton];
        
        overlayImage.layer.cornerRadius = self.layer.cornerRadius;
        overlayImage.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat contentSize = 35 * 2 + 5;
    CGFloat contentTop = (self.frame.size.height - contentSize) / 2 - 10;
    infoButton.frame = CGRectMake(0, contentTop, self.frame.size.width, 35);
    statButton.frame = CGRectMake(0, contentTop + 35 + 5, self.frame.size.width, 35);
    overlayImage.frame = self.bounds;
}

@end
