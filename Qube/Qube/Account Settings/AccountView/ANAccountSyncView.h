//
//  ANAccountSyncView.h
//  Qube
//
//  Created by Alex Nichol on 9/14/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPeriodicLineView.h"
#import "ANLoadingKnob.h"

@interface ANAccountSyncView : ANPeriodicLineView {
    UILabel * autosyncLabel;
    UISwitch * autosyncSwitch;
    UILabel * statusLabel;
    ANLoadingKnob * loadingKnob;
}

@property (readonly) UISwitch * autosyncSwitch;
@property (readonly) UILabel * statusLabel;
@property (readonly) ANLoadingKnob * loadingKnob;

- (void)setStatus:(NSString *)status;
- (void)setFailed:(NSString *)message;

@end
