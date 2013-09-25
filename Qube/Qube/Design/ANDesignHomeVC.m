//
//  ANSettingsHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDesignHomeVC.h"

@interface ANDesignHomeVC ()

@end

@implementation ANDesignHomeVC

- (id)init {
    if ((self = [super init])) {
        self.title = @"Design";
        self.view.backgroundColor = [ANQubeTheme lightBackgroundColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"design"];
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
