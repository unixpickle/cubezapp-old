//
//  ANImagePickerMenuVC.m
//  Qube
//
//  Created by Alex Nichol on 9/27/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImagePickerMenuVC.h"

@interface ANImagePickerMenuVC ()

@end

@implementation ANImagePickerMenuVC

@synthesize puzzleColor;

- (id)init {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        self.title = @"Image Picker";
        categories = [ANPuzzlePhotoCategory categories];
    }
    return self;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"Upload Image", @"Preset Images"][section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"Cell"];
        }
        cell.textLabel.text = @"Photo Library";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        ANImageCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        if (!cell) {
            cell = [[ANImageCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"CategoryCell"];
        }
        ANPuzzlePhotoCategory * category = categories[indexPath.row];
        cell.textLabel.text = category.name;
        cell.categoryImage.image = category.thumbnail;
        cell.imageContainer.backgroundColor = puzzleColor;
        cell.categoryImage.layer.cornerRadius = 5;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
        return;
    }
    
    ANPuzzlePhotoCategory * category = categories[indexPath.row];
    ANImagePickerGridVC * grid = [[ANImagePickerGridVC alloc] initWithImageNames:category.imageNames puzzleColor:puzzleColor];
    grid.delegate = self.delegate;
    grid.title = category.name;
    [self.navigationController pushViewController:grid animated:YES];
}

#pragma mark - Image Picker -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    image = [[image fixOrientation] imageFittingFrame:CGSizeMake(228, 228)];
    NSData * png = UIImagePNGRepresentation(image);
    picker.delegate = nil;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:^ {
        [self.delegate imagePicker:self pickedImageData:png image:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
