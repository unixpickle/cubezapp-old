//
//  ANTimerFlowVC.h
//  Qube
//
//  Created by Alex Nichol on 10/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANOfflineSession.h"
#import "ANSlidingNavBar.h"

@interface ANTimerFlowVC : UIViewController {
    ANOfflineSession * session;
    ANSlidingNavBar * navBar;
}

@property (readonly) ANOfflineSession * session;

- (id)initWithPuzzle:(ANPuzzle *)puzzle;
- (void)handlePuzzleDeleted;

- (void)donePressed:(id)sender;
- (void)statsPressed:(id)sender;

@end
