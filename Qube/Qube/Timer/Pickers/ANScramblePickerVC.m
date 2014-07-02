//
//  ANScramblePickerVC.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANScramblePickerVC.h"

@interface ANScramblePickerVC ()

@end

@implementation ANScramblePickerVC

- (id)initWithScramblerNames:(NSArray *)names currentName:(NSString *)name {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        scramblerNames = names;
        currentName = name;
        self.title = @"Scramble";
        
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[names indexOfObject:name]
                                                                  inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:YES];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return scramblerNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = scramblerNames[indexPath.row];
    
    if ([scramblerNames[indexPath.row] isEqualToString:currentName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate scramblePicker:self picked:scramblerNames[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
