//
//  ANTimerHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimerHomeVC.h"

@interface ANTimerHomeVC ()

@end

@implementation ANTimerHomeVC

- (id)init {
    if ((self = [super init])) {
        self.title = @"Timer";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"clock"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"clock_highlighted"];
        
        editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                   target:self
                                                                   action:@selector(editPressed:)];
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                  target:self
                                                                  action:@selector(addPressed:)];
        doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self
                                                                   action:@selector(donePressed:)];
        self.navigationItem.rightBarButtonItem = editButton;
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

#pragma mark - Actions -

- (void)editPressed:(id)sender {
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
}

- (void)donePressed:(id)sender {
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

- (void)addPressed:(id)sender {
    NSLog(@"add pressed");
}

@end
