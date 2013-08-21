//
//  ANSettingsHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSettingsHomeVC.h"

@interface ANSettingsHomeVC ()

@end

@implementation ANSettingsHomeVC

- (id)init {
    if ((self = [super init])) {
        self.title = @"Settings";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"gear"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"gear_highlighted"];
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
