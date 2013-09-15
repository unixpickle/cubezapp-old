//
//  ANAccountSyncView.m
//  Qube
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAccountSyncView.h"

@implementation ANAccountSyncView

@synthesize autosyncSwitch;
@synthesize statusLabel;
@synthesize loadingKnob;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        autosyncLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 100, 44)];
        autosyncLabel.text = @"Automatically sync";
        autosyncLabel.backgroundColor = [UIColor clearColor];
        
        autosyncSwitch = [[UISwitch alloc] init];
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, frame.size.width - 100, 44)];
        statusLabel.text = @"Not currently syncing";
        statusLabel.backgroundColor = [UIColor clearColor];
        
        loadingKnob = [[ANLoadingKnob alloc] initWithFrame:CGRectMake(frame.size.width - 50, 46, 40, 40)];
        [loadingKnob setKnobImage:[UIImage imageNamed:@"refresh_dark"]];
        
        [self addSubview:autosyncLabel];
        [self addSubview:autosyncSwitch];
        [self addSubview:statusLabel];
        [self addSubview:loadingKnob];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    autosyncLabel.frame = CGRectMake(10, 0, self.frame.size.width - autosyncSwitch.frame.size.width - 20, 44);
    autosyncSwitch.frame = CGRectMake(self.frame.size.width - autosyncSwitch.frame.size.width - 10,
                                      (44 - autosyncSwitch.frame.size.height) / 2.0,
                                      autosyncSwitch.frame.size.width,
                                      autosyncSwitch.frame.size.height);
    statusLabel.frame = CGRectMake(10, 44, self.frame.size.width - 60, 44);
    loadingKnob.frame = CGRectMake(self.frame.size.width - 50, 46, 40, 40);
}

- (void)setStatus:(NSString *)status {
    statusLabel.text = status;
    statusLabel.textColor = [UIColor blackColor];
}

- (void)setFailed:(NSString *)message {
    statusLabel.text = message;
    statusLabel.textColor = [UIColor redColor];
}

@end
