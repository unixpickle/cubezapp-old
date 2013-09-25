//
//  ANTimerHomeVC.m
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimerHomeVC.h"
#import "ANAppDelegate.h"

@implementation ANTimerHomeVC

@synthesize accountButton;
@synthesize gridView;

- (id)init {
    if ((self = [super init])) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.title = @"Timer";
        self.view.backgroundColor = [ANQubeTheme lightBackgroundColor];
        
        self.tabBarItem.image = [UIImage imageNamed:@"clock"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"clock_highlighted"];
        
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                  target:self
                                                                  action:@selector(addPressed:)];
        accountButton = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(accountPressed:)];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(donePressed:)];
        
        self.navigationItem.rightBarButtonItem = accountButton;
        self.navigationItem.leftBarButtonItem = addButton;
        
        self.view.autoresizesSubviews = NO;
        
        CGRect gridFrame = self.view.bounds;
        gridFrame.origin.y += 44 + 20;
        gridFrame.size.height -= 44 + 20 + 50;
        NSArray * puzzles = [[ANDataManager sharedDataManager].activeAccount.puzzles array];
        gridView = [[ANPuzzleGrid alloc] initWithFrame:gridFrame puzzles:puzzles];
        gridView.delegate = self;
        gridView.puzzlesDelegate = self;
        [self.view addSubview:gridView];
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
    
    ANPuzzle * puzzle = [[ANDataManager sharedDataManager] createUnownedPuzzleObject];
    [puzzle setDefaultFields:ANPuzzleType3x3];
    puzzle.name = @"3x3x3";
    
    ANEditPuzzleVC * editVC = [[ANEditPuzzleVC alloc] initWithPuzzle:puzzle];
    editVC.delegate = self;
    UINavigationController * controller = [[UINavigationController alloc] init];
    controller.navigationBar.barStyle = UIBarStyleDefault;
    [controller pushViewController:editVC animated:NO];
    
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController presentViewController:controller
                                          animated:YES
                                        completion:nil];
}

- (void)donePressed:(id)sender {
    [gridView stopEditing];
}

#pragma mark - Grid View -

- (void)gridView:(ANGridView *)gridView item:(ANGridViewItem *)item movedTo:(ANGridViewItem *)another {
    // TODO: here, we will reorder the account's internal order representation
}

- (void)gridViewDidBeginEditing:(ANGridView *)gridView {
    [self.navigationItem setLeftBarButtonItem:doneButton animated:YES];
}

- (void)gridViewDidEndEditing:(ANGridView *)gridView {
    [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
}

- (void)gridView:(ANGridView *)gridView willDelete:(ANGridViewItem *)item {
    ANPuzzle * puzzle = item.userInfo;
    NSString * string = [NSString stringWithFormat:@"You are about to delete \"%@\".", puzzle.name];
    UIAlertView * deleteAlert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                           message:string
                                                          delegate:self
                                                 cancelButtonTitle:@"Delete"
                                                 otherButtonTitles:@"Cancel", nil];
    [deleteAlert show];
    deletingPuzzle = puzzle;
}

- (void)puzzleGrid:(ANPuzzleGrid *)grid showStats:(ANPuzzle *)aPuzzle {
    
}

- (void)puzzleGrid:(ANPuzzleGrid *)grid showInfo:(ANPuzzle *)aPuzzle {
    isAdding = NO;
    ANEditPuzzleVC * editVC = [[ANEditPuzzleVC alloc] initWithPuzzle:aPuzzle];
    editVC.delegate = self;
    editVC.navigationItem.leftBarButtonItem = nil;
    editVC.title = @"Edit";
    UINavigationController * controller = [[UINavigationController alloc] init];
    controller.navigationBar.barStyle = UIBarStyleDefault;
    [controller pushViewController:editVC animated:NO];
    
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.viewController presentViewController:controller
                                          animated:YES
                                        completion:nil];
}

#pragma mark - Puzzle Editor -

- (void)editPuzzleVCCancelled:(ANEditPuzzleVC *)vc {
    
}

- (void)editPuzzleVCDone:(ANEditPuzzleVC *)vc {
    if (!isAdding) {
        [self.gridView externalPuzzleUpdated:vc.puzzle];
        return;
    }
    [[ANDataManager sharedDataManager].context insertObject:vc.puzzle.ocAddition];
    [[ANDataManager sharedDataManager].context insertObject:vc.puzzle];
    [[ANDataManager sharedDataManager].activeAccount.changes addPuzzleAdditionsObject:vc.puzzle.ocAddition];
    [[ANDataManager sharedDataManager].activeAccount addPuzzlesObject:vc.puzzle];
    [self.gridView externalPuzzleAdded:vc.puzzle];
}

#pragma mark - Alert View -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete"]) {
        [self.gridView externalPuzzleDeleted:deletingPuzzle];
        [deletingPuzzle offlineDelete];
    }
}

@end
