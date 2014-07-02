//
//  ANTimePickerVC.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTimePickerVC.h"

@interface ANTimePickerVC ()

@end

@implementation ANTimePickerVC

- (id)initWithTime:(NSTimeInterval)time {
    if ((self = [super init])) {
        currentTime = [NSNumber numberWithInt:(int)time];
        timeOptions = @[@0, @3, @5, @10, @15, @20];
        self.title = @"Inspection Time";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return timeOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d seconds", [timeOptions[indexPath.row] intValue]];
    if ([currentTime isEqualToNumber:timeOptions[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate timePicker:self
                    choseTime:[timeOptions[indexPath.row] doubleValue]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
