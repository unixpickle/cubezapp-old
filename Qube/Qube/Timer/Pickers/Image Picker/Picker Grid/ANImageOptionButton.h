//
//  ANImageOptionButton.h
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANImageOptionButton : UIButton {
    UIImageView * thumbnail;
    NSString * imageName;
    UIActivityIndicatorView * loader;
}

@property (readonly) NSString * imageName;
@property (readonly) UIImageView * thumbnail;
@property (readonly) UIActivityIndicatorView * loader;

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)theImageName;

@end
