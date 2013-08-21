//
//  ANStatHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANStatHomeVC.h"

@interface ANStatHomeVC ()

@end

@implementation ANStatHomeVC

- (id)init {
    if ((self = [super init])) {
        self.title = @"Stat";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"calculator"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"calculator_highlighted"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
