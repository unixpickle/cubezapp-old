//
//  ANTimerFlowVC.m
//  Qube
//
//  Created by Alex Nichol on 10/11/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimerFlowVC.h"

@interface ANTimerFlowVC ()

@end

@implementation ANTimerFlowVC

@synthesize session;

- (id)initWithPuzzle:(ANPuzzle *)puzzle {
    if ((self = [super init])) {
        self.view.backgroundColor = [ANQubeTheme lightBackgroundColor];
        session = [[ANOfflineSession alloc] initWithPuzzle:puzzle];
        
        UIView * titleBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        navBar = [[ANSlidingNavBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
        titleBg.backgroundColor = navBar.backgroundColor;
        
        UIButton * endButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [endButton setTitle:@"UIAlert" forState:UIControlStateNormal];
        [endButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [endButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
        navBar.backButton = endButton;
        
        UIButton * statsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [statsButton setTitle:@"Stats" forState:UIControlStateNormal];
        [statsButton.titleLabel setFont:endButton.titleLabel.font];
        [statsButton addTarget:self action:@selector(statsPressed:) forControlEvents:UIControlEventTouchUpInside];
        navBar.statsButton = statsButton;
        
        [self.view addSubview:titleBg];
        [self.view addSubview:navBar];
        
        titleBg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        navBar.titleLabel.text = puzzle.name;
    }
    return self;
}

- (void)handlePuzzleDeleted {
    session.puzzle = nil;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Actions -

- (void)donePressed:(id)sender {
    // TODO: here, generate an online version of the solves if this session was online
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)statsPressed:(id)sender {
    
}

@end
