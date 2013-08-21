//
//  ANViewController.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANViewController.h"

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // generate a navigation controller for each page
    NSArray * vcClasses = @[[ANTimerHomeVC class], [ANStatHomeVC class],
                            [ANSettingsHomeVC class]];
    NSMutableArray * vcs = [NSMutableArray array];
    for (Class vcClass in vcClasses) {
        UIViewController * vc = [[vcClass alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] init];
        [nvc pushViewController:vc animated:NO];
        nvc.tabBarItem = vc.tabBarItem;
        [vcs addObject:nvc];
    }
    self.viewControllers = vcs;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
