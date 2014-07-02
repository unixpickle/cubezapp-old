//
//  ANStatsPreview.m
//  Qube
//
//  Created by Alex Nichol on 10/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANStatsPreview.h"

@implementation ANStatsPreview

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ANQubeTheme lightBackgroundColor];
    }
    return self;
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
