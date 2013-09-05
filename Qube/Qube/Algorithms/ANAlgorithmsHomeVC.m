//
//  ANAlgorithmsHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 9/3/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAlgorithmsHomeVC.h"

@interface ANAlgorithmsHomeVC ()

@end

@implementation ANAlgorithmsHomeVC

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Algs";
        self.view.backgroundColor = [UIColor blackColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"algs"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
