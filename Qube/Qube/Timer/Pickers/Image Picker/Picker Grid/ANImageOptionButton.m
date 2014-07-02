//
//  ANImageOptionButton.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImageOptionButton.h"

@implementation ANImageOptionButton

@synthesize imageName;
@synthesize thumbnail;
@synthesize loader;

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)theImageName {
    self = [super initWithFrame:frame];
    if (self) {
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        loader.hidesWhenStopped = YES;
        [loader startAnimating];
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 5, 5)];
        
        imageName = theImageName;
        
        self.layer.cornerRadius = 5;
        [self addSubview:thumbnail];
        [self addSubview:loader];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    loader.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    thumbnail.frame = CGRectInset(self.bounds, 5, 5);
}

@end
