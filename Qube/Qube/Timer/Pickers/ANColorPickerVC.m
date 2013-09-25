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
        initialColor = color;
        colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280) / 2,
                                                                          (self.view.frame.size.height - 320) / 2,
                                                                          280, 280)];
        [colorPicker setCropToCircle:YES];
        [self.view addSubview:colorPicker];
        [colorPicker setBackgroundColor:[UIColor clearColor]];
        
        self.view.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(colorPickerReady:)
                                                     name:RSColorPickerViewReadyNotification
                                                   object:colorPicker];
        
        self.view.backgroundColor =  [ANQubeTheme lightBackgroundColor];
    }
    return self;
}

- (void)colorPickerReady:(NSNotification *)note {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [colorPicker setSelectionColor:initialColor];
    brightness = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(colorPicker.frame.origin.x,
                                                                      CGRectGetMaxY(colorPicker.frame) + 10,
                                                                      colorPicker.frame.size.width, 30)];
    [brightness setColorPicker:colorPicker];
    [self.view addSubview:brightness];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.delegate colorPicker:self pickedColor:colorPicker.selectionColor];
}

@end
