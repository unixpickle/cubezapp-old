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
@synthesize gridView;

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
        self.navigationItem.leftBarButtonItem = addButton;
        
        gridView = [[ANGridView alloc] initWithFrame:self.view.bounds];
    }
    return self;
}

#pragma mark - Actions -

- (void)accountPressed:(id)sender {
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController flipToAccountsSettings];
}

- (void)addPressed:(id)sender {
    isAdding = YES;
    
    ANPuzzle * puzzle = [[ANDataManager sharedDataManager] createPuzzleObject];
    [puzzle setDefaultFields:ANPuzzleType3x3];
    puzzle.name = @"3x3x3";
    
    ANEditPuzzleVC * editVC = [[ANEditPuzzleVC alloc] initWithPuzzle:puzzle];
    UINavigationController * controller = [[UINavigationController alloc] init];
    controller.navigationBar.barStyle = UIBarStyleBlack;
    [controller pushViewController:editVC animated:NO];
    
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController presentViewController:controller
                                          animated:YES
                                        completion:nil];
    
    
}

#pragma mark - Grid View -

- (void)gridViewDidReorder:(ANGridView *)gridView {
    
}

- (void)gridViewDidBeginEditing:(ANGridView *)gridView {
    
}

- (void)gridViewDidEndEditing:(ANGridView *)gridView {
    
}

- (void)gridView:(ANGridView *)gridView willDelete:(ANGridViewItem *)item {
    
}

#pragma mark - Puzzle Editor -

- (void)editPuzzleVCCancelled:(ANEditPuzzleVC *)vc {
    [[ANDataManager sharedDataManager].context deleteObject:vc.puzzle];
}

- (void)editPuzzleVCDone:(ANEditPuzzleVC *)vc {
    [[ANDataManager sharedDataManager].activeAccount addPuzzlesObject:vc.puzzle];
}

@end
