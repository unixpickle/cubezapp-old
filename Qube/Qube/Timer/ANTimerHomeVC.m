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
    
    uint32_t randomIndex = arc4random() % [ANQubeTheme supportedGridColors].count;
    UIColor * color = [[ANQubeTheme supportedGridColors] objectAtIndex:randomIndex][@"color"];
    [puzzle offlineSetIconColor:[color hexValueData]];
    
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
    ANPuzzle * moving = item.userInfo;
    ANPuzzle * destination = another.userInfo;
    
    NSMutableArray * puzzles = [[[ANDataManager sharedDataManager].activeAccount.puzzles array] mutableCopy];
    NSInteger currentIndex = [puzzles indexOfObject:moving];
    NSInteger index = [puzzles indexOfObject:destination];
    if (currentIndex < index) {
        // we are moving the cell up, meaning we should move back
        // all the other items in the list
        for (int i = currentIndex; i < index; i++) {
            puzzles[i] = puzzles[i + 1];
        }
    } else if (currentIndex > index) {
        // moving the cell back, we should move up all items
        for (int i = currentIndex; i > index; i--) {
            puzzles[i] = puzzles[i - 1];
        }
    }
    puzzles[index] = moving;
    [ANDataManager sharedDataManager].activeAccount.puzzles = [NSOrderedSet orderedSetWithArray:puzzles];
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
