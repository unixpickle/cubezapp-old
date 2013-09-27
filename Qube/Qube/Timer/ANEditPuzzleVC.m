//
//  ANAddPuzzleVC.m
//  Qube
//
//  Created by Alex Nichol on 9/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANEditPuzzleVC.h"

@interface ANEditPuzzleVC (Private)

- (NSArray *)sectionFields;
- (void)updateChangedFields;

@end

@implementation ANEditPuzzleVC

@synthesize delegate;
@synthesize puzzle;

- (id)initWithPuzzle:(ANPuzzle *)aPuzzle {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        puzzle = aPuzzle;
        self.title = @"Puzzle";
        self.view.backgroundColor =  [ANQubeTheme lightBackgroundColor];
        
        doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self
                                                                   action:@selector(donePressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        
        cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                     target:self
                                                                     action:@selector(cancelPressed:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
        [ANImageManager sharedImageManager].editingPuzzle = puzzle;
    }
    return self;
}

- (void)donePressed:(id)sender {
    [ANImageManager sharedImageManager].editingPuzzle = nil;
    [self updateChangedFields];
    [delegate editPuzzleVCDone:self];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelPressed:(id)sender {
    [ANImageManager sharedImageManager].editingPuzzle = nil;
    [delegate editPuzzleVCCancelled:self];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)puzzleChanged:(id)sender {
    puzzleImage = [[ANImageManager sharedImageManager] imageForHash:puzzle.image];
    
}

#pragma mark - Text Field -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self updateChangedFields];
    return NO;
}

#pragma mark - Table View -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self sectionFields].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self sectionFields][section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * info = [self sectionFields][indexPath.section][indexPath.row];
    ANSmallDetailCell * retCell = nil;
    retCell = [tableView dequeueReusableCellWithIdentifier:info[@"type"]];
    if (!retCell) {
        NSDictionary * cellClasses = @{@"entry": [ANTextEntryCell class],
                                       @"info": [ANTextInfoCell class],
                                       @"color": [ANColorPickerCell class]};
        retCell = [[cellClasses[info[@"type"]] alloc] initWithNameWidth:60
                                                        reuseIdentifier:info[@"type"]];
    }
    if ([info[@"type"] isEqualToString:@"entry"]) {
        ANTextEntryCell * entry = (ANTextEntryCell *)retCell;
        entry.textField.delegate = self;
        
        // TODO: this may need to be changed if
        // another text entry is added
        nameField = entry.textField;
    }
    [retCell setCellValue:info[@"value"]];
    retCell.nameLabel.text = info[@"name"];
    retCell.accessoryType = ([info[@"disclosure"] boolValue] ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone);
    return retCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        ANPuzzleTypePickerVC * picker = [[ANPuzzleTypePickerVC alloc] initWithSelected:self.puzzle.type];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        UIColor * color = [UIColor colorWithHexValueData:self.puzzle.iconColor];
        ANColorPickerVC * picker = [[ANColorPickerVC alloc] initWithColor:color];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Cell Info

- (NSArray *)sectionFields {
    return @[
             @[
                 @{@"name": @"Name", @"value": self.puzzle.name,
                   @"type": @"entry"},
                 @{@"name": @"Type", @"value": PuzzleNames[self.puzzle.type],
                   @"type": @"info", @"disclosure": @YES}
              ],
             @[
                 @{@"name": @"Color", @"value": [UIColor colorWithHexValueData:self.puzzle.iconColor],
                   @"type": @"color", @"disclosure": @YES}
              ]
            ];
}

- (void)updateChangedFields {
    if (![self.puzzle.name isEqualToString:nameField.text] && nameField.text) {
        [self.puzzle offlineSetName:nameField.text];
    }
}

#pragma mark - View Callbacks -

- (void)puzzleTypePicker:(ANPuzzleTypePickerVC *)picker selected:(ANPuzzleType)type {
    // check if they've changed the name yet
    BOOL hasRenamed = ![self.puzzle.name isEqualToString:PuzzleNames[self.puzzle.type]];
    [self.puzzle setDefaultFields:type];
    if (!hasRenamed) {
        [self.puzzle offlineSetName:PuzzleNames[type]];
    }
    [self.tableView reloadData];
}

- (void)colorPicker:(ANColorPickerVC *)picker pickedColor:(UIColor *)color {
    [self.puzzle offlineSetIconColor:[color hexValueData]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
}

@end
