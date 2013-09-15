//
//  ANAccountPage.h
//  Qube
//
//  Created by Alex Nichol on 9/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kANAccountPageButtonFrame CGRectMake(0, 0, 200, 67)
#define kANAccountPageButtonFont [UIFont fontWithName:@"Avenir-Black" size:20]

@protocol ANAccountPage <NSObject>

@property (readonly) UIControl * button;

@end
