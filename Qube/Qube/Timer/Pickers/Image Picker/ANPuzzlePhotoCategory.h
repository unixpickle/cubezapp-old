//
//  ANPuzzlePhotoCategory.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANPuzzlePhotoCategory : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) UIImage * thumbnail;
@property (nonatomic, retain) NSArray * imageNames;

+ (NSArray *)categories;
+ (ANPuzzlePhotoCategory *)categoryWithName:(NSString *)name thumbnail:(UIImage *)thum names:(NSArray *)names;

@end
