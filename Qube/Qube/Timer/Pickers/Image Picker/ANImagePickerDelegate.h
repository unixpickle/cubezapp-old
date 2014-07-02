//
//  ANImagePickerDelegate.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANImagePickerDelegate <NSObject>

- (void)imagePicker:(UIViewController *)sender pickedImageData:(NSData *)pngData image:(UIImage *)image;

@end
