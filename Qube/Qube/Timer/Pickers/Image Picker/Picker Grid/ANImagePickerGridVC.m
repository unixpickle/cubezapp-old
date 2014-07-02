//
//  ANImagePickerGridVC.m
//  Qube
//
//  Created by Alex Nichol on 9/29/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImagePickerGridVC.h"

@interface ANImagePickerGridVC ()

- (void)loadNextImage;
- (void)imageButtonPressed:(id)sender;

@end

@implementation ANImagePickerGridVC

@synthesize delegate;

- (id)initWithImageNames:(NSArray *)names puzzleColor:(UIColor *)color {
    if ((self = [super init])) {
        self.view.backgroundColor = [ANQubeTheme lightBackgroundColor];
        imageNames = names;
        imageCells = [NSMutableArray array];
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        NSInteger row = 0, column = 0;
        
        CGFloat itemSize = (self.view.frame.size.width - (kANImagePickerGridSpacing * (kANImagePickerGridRowSize + 1)));
        itemSize /= kANImagePickerGridRowSize;
        
        for (NSInteger i = 0; i < names.count; i++) {
            NSString * name = names[i];
            CGFloat xValue = kANImagePickerGridSpacing * (column + 1) + itemSize * column;
            CGFloat yValue = kANImagePickerGridSpacing * (row + 1) + itemSize * row;
            ANImageOptionButton * button = [[ANImageOptionButton alloc] initWithFrame:CGRectMake(xValue, yValue, itemSize, itemSize)
                                                                            imageName:name];
            [scrollView addSubview:button];
            [imageCells addObject:button];
            button.backgroundColor = color;
            
            column++;
            if (column == kANImagePickerGridRowSize) {
                row++;
                column = 0;
            }
        }
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                            CGRectGetMaxY([[imageCells lastObject] frame]) + 10);
        
        [self.view addSubview:scrollView];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self performSelector:@selector(loadNextImage) withObject:nil afterDelay:0.01];
}

- (void)loadNextImage {
    if (imagesLoaded == [imageCells count]) {
        return;
    }
    ANImageOptionButton * button = imageCells[imagesLoaded++];
    UIImage * image = [UIImage imageNamed:button.imageName];
    button.thumbnail.image = image;
    [button.loader stopAnimating];
    
    [button addTarget:self action:@selector(imageButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self performSelector:@selector(loadNextImage) withObject:Nil afterDelay:0.01];
}

- (void)imageButtonPressed:(id)sender {
    ANImageOptionButton * button = sender;
    NSString * path = [[NSBundle mainBundle] pathForResource:[button.imageName stringByAppendingString:@"@2x"]
                                                                                                ofType:@"png"];
    [self.delegate imagePicker:self pickedImageData:[NSData dataWithContentsOfFile:path] image:button.thumbnail.image];
}

@end
