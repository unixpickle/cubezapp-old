//
//  ANTimerHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimerHomeVC.h"
#import "ANAppDelegate.h"

@interface ANTimerHomeVC ()

@end

@implementation ANTimerHomeVC

@synthesize accountButton;

- (id)init {
    if ((self = [super init])) {
        self.title = @"Timer";
        self.view.backgroundColor = [UIColor blackColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"clock"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"clock_highlighted"];
        
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                  target:self
                                                                  action:@selector(addPressed:)];
        accountButton = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(accountPressed:)];
        self.navigationItem.rightBarButtonItem = accountButton;
    }
    return self;
}

#pragma mark - Actions -

- (void)accountPressed:(id)sender {
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController flipToAccountsSettings];
}

- (void)addPressed:(id)sender {
    NSLog(@"add pressed");
}

@end
