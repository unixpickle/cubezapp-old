//
//  ANPuzzleTypePickerVC.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzleTypePickerVC.h"

@interface ANPuzzleTypePickerVC ()

@end

@implementation ANPuzzleTypePickerVC

- (id)initWithSelected:(ANPuzzleType)type {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        self.title = @"Puzzle Type";
        NSMutableArray * mNames = [NSMutableArray array];
        for (int i = 0; i < kANPuzzleTypeCount; i++) {
            [mNames addObject:PuzzleNames[i]];
        }
        names = mNames;
        selectedName = (NSInteger)type;
        self.view.backgroundColor =  [ANQubeTheme lightBackgroundColor];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = names[indexPath.row];
    cell.accessoryType = (indexPath.row == selectedName ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedName) {
        [self.delegate puzzleTypePicker:self selected:(ANPuzzleType)indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
