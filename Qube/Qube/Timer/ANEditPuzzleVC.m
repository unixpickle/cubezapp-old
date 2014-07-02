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
- (NSArray *)headings;
- (void)updateChangedFields;
- (BOOL)canGenerateScrambles;
- (BOOL)canShowScrambles;

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
        
        puzzleImage = [[ANImageManager sharedImageManager] imageForHash:puzzle.image];
    }
    return self;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)donePressed:(id)sender {
    // TODO: make sure they don't add a puzzle with the same name twice
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
    [self.tableView reloadData];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self headings][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * info = [self sectionFields][indexPath.section][indexPath.row];
    ANSmallDetailCell * retCell = nil;
    retCell = [tableView dequeueReusableCellWithIdentifier:info[@"type"]];
    NSArray * nameWidths = @[@60, @60, @0, @120, @90];
    if (!retCell) {
        NSDictionary * cellClasses = @{@"entry": [ANTextEntryCell class],
                                       @"info": [ANTextInfoCell class],
                                       @"color": [ANColorPickerCell class],
                                       @"image": [ANImagePickerCell class],
                                       @"time": [ANTimePickerCell class],
                                       @"flag": [ANFlagSetterCell class]};
        NSString * reuseId = [NSString stringWithFormat:@"%@%d", info[@"type"], [nameWidths[indexPath.section] intValue]];
        retCell = [[cellClasses[info[@"type"]] alloc] initWithNameWidth:[nameWidths[indexPath.section] floatValue]
                                                        reuseIdentifier:reuseId];
    }
    if ([info[@"type"] isEqualToString:@"entry"]) {
        ANTextEntryCell * entry = (ANTextEntryCell *)retCell;
        entry.textField.delegate = self;
        
        // TODO: this may need to be changed if
        // another text entry is added
        nameField = entry.textField;
    } else if ([info[@"type"] isEqualToString:@"flag"]) {
        [(ANFlagSetterCell *)retCell setDelegate:self];
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
    } else if (indexPath.section == 2) {
        ANImagePickerMenuVC * picker = [[ANImagePickerMenuVC alloc] init];
        picker.puzzleColor = [UIColor colorWithHexValueData:self.puzzle.iconColor];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        ANTimePickerVC * picker = [[ANTimePickerVC alloc] initWithTime:self.puzzle.inspectionTime];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
    } else if (indexPath.section == 4 && [[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ANTextInfoCell class]]) {
        NSArray * names = [[ANScramblerList defaultScramblerList] scramblerNamesForPuzzle:self.puzzle.type];
        id<ANPuzzleScrambler> scrambler = [[ANScramblerList defaultScramblerList] scramblerForPuzzle:self.puzzle.type
                                                                                              length:self.puzzle.scrambleLength];
        NSString * current = [scrambler.class labelForLength:self.puzzle.scrambleLength];
        ANScramblePickerVC * picker = [[ANScramblePickerVC alloc] initWithScramblerNames:names currentName:current];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        return -1;
    }
    return 200;
}

#pragma mark Cell Info

- (NSArray *)sectionFields {
    UIColor * puzzleColor = [UIColor colorWithHexValueData:self.puzzle.iconColor];
    NSDictionary * cellInfo = @{@"name": self.puzzle.name, @"image": puzzleImage,
                                @"color": puzzleColor};
    NSMutableArray * basics = [@[
             @[
                 @{@"name": @"Name", @"value": self.puzzle.name,
                   @"type": @"entry"},
                 @{@"name": @"Type", @"value": PuzzleNames[self.puzzle.type],
                   @"type": @"info", @"disclosure": @YES}
              ],
             @[
                 @{@"name": @"Color", @"value": puzzleColor,
                   @"type": @"color", @"disclosure": @YES}
              ],
             @[
                 @{@"name": @"Image", @"value": cellInfo,
                   @"type": @"image", @"disclosure": @YES}],
             @[
                 @{@"name": @"Inspection", @"value": @(self.puzzle.inspectionTime),
                   @"type": @"time", @"disclosure": @YES},
                 @{@"name": @"Show Stats", @"value": @(self.puzzle.showStats),
                   @"type": @"flag"}]
            ] mutableCopy];
    if ([self canGenerateScrambles]) {
        id<ANPuzzleScrambler> scrambler = [[ANScramblerList defaultScramblerList] scramblerForPuzzle:self.puzzle.type
                                                                                              length:self.puzzle.scrambleLength];
        NSString * lengthName = [scrambler.class labelForLength:self.puzzle.scrambleLength];
        if (!lengthName) lengthName = @"(null)";
        NSMutableArray * scrambleFields = [@[
                                             @{@"name": @"Generate", @"value": @(self.puzzle.scramble),
                                               @"type": @"flag"},
                                             ] mutableCopy];
        if (self.puzzle.scramble) {
            [scrambleFields addObject:@{@"name": @"Length", @"value": lengthName,
                                        @"type": @"info", @"disclosure": @"YES"}];
        }
        if ([self canShowScrambles] && self.puzzle.scramble) {
            [scrambleFields insertObject:@{@"name": @"Show", @"value": @(self.puzzle.showScramble),
                                           @"type": @"flag"} atIndex:1];
        }
        [basics addObject:scrambleFields];
    }
    return basics;
}

- (NSArray *)headings {
    return @[@"Basic Settings", @"Color", @"Image", @"Timer Screen", @"Scramble Settings"];
}

- (void)updateChangedFields {
    if (![self.puzzle.name isEqualToString:nameField.text] && nameField.text) {
        [self.puzzle offlineSetName:nameField.text];
    }
}

- (BOOL)canGenerateScrambles {
    return [[ANScramblerList defaultScramblerList] scramblersForPuzzle:self.puzzle.type].count != 0;
}

- (BOOL)canShowScrambles {
    return [[ANRendererList defaultRendererList] rendererForPuzzle:self.puzzle.type] != nil;
}

#pragma mark - View Callbacks -

- (void)puzzleTypePicker:(ANPuzzleTypePickerVC *)picker selected:(ANPuzzleType)type {
    // check if they've changed the name yet
    BOOL hasRenamed = ![self.puzzle.name isEqualToString:PuzzleNames[self.puzzle.type]];
    [self.puzzle setDefaultFields:type];
    if (!hasRenamed) {
        [self.puzzle offlineSetName:PuzzleNames[type]];
    }
    [self puzzleChanged:nil];
}

- (void)colorPicker:(ANColorPickerVC *)picker pickedColor:(UIColor *)color {
    [self.puzzle offlineSetIconColor:[color hexValueData]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)imagePicker:(UIViewController *)sender pickedImageData:(NSData *)pngData image:(UIImage *)image {
    if (pngData) {
        NSData * identifier = [[ANImageManager sharedImageManager] registerImageData:pngData];
        [self.puzzle offlineSetImage:identifier];
        puzzleImage = image;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.navigationController popToViewController:self animated:YES];
}

- (void)flagSetterCell:(ANFlagSetterCell *)cell switched:(BOOL)on {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 3) {
        // its the show scrambles field
        [self.puzzle offlineSetShowStats:on];
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self.puzzle offlineSetScramble:on];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4]
                          withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self.puzzle offlineSetShowScramble:on];
        }
    }
}

- (void)timePicker:(ANTimePickerVC *)picker choseTime:(NSTimeInterval)time {
    [self.puzzle offlineSetInspectionTime:time];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)scramblePicker:(ANScramblePickerVC *)picker picked:(NSString *)name {
    NSInteger length = 0;
    if ([[ANScramblerList defaultScramblerList] scramblerForPuzzle:self.puzzle.type name:name length:&length]) {
        [self.puzzle offlineSetScrambleLength:length];
        [self.tableView beginUpdates];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4]
                      withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

@end
