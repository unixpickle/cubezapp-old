//
//  ANImageCategoryCell.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANImageCategoryCell : UITableViewCell {
    UIView * imageContainer;
    UIImageView * categoryImage;
}

@property (readonly) UIView * imageContainer;
@property (readonly) UIImageView * categoryImage;

@end
