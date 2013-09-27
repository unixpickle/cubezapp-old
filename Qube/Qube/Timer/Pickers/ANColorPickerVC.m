//
//  ANColorPickerVC.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANColorPickerVC.h"

@interface ANColorPickerVC ()

@end

@implementation ANColorPickerVC

- (id)initWithColor:(UIColor *)color {
    if ((self = [super init])) {
        self.title = @"Colors";
        
        colors = [ANQubeTheme supportedGridColors];
        CGFloat red, green, blue;
        [color getRed:&red green:&green blue:&blue alpha:NULL];
        for (NSInteger i = 0; i < colors.count; i++) {
            NSDictionary * info = colors[i];
            UIColor * aColor = info[@"color"];
            CGFloat aRed, aGreen, aBlue;
            [aColor getRed:&aRed green:&aGreen blue:&aBlue alpha:NULL];
            if (fabs(aRed - red) < 0.01 && fabs(aGreen - green) < 0.01 && fabs(aBlue - blue) < 0.01) {
                initialIndex = i;
                break;
            }
        }
        
        self.view.backgroundColor =  [UIColor whiteColor];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ANColorOptionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[ANColorOptionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:@"Cell"];
    }
    
    NSDictionary * info = colors[indexPath.row];
    cell.nameLabel.text = info[@"name"];
    cell.colorPreview.backgroundColor = info[@"color"];
    
    if (indexPath.row == initialIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * info = colors[indexPath.row];
    [self.delegate colorPicker:self pickedColor:info[@"color"]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
