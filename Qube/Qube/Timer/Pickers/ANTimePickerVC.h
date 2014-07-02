//
//  ANTimePickerVC.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANTimePickerVC;

@protocol ANTimePickerVCDelegate

- (void)timePicker:(ANTimePickerVC *)picker choseTime:(NSTimeInterval)time;

@end

@interface ANTimePickerVC : UITableViewController {
    NSArray * timeOptions;
    NSNumber * currentTime;
}

@property (nonatomic, weak) id<ANTimePickerVCDelegate> delegate;

- (id)initWithTime:(NSTimeInterval)time;

@end
