//
//  ANControlledNavController.m
//  Qube
//
//  Created by Alex Nichol on 10/12/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANControlledNavController.h"

@interface ANControlledNavController ()

@end

@implementation ANControlledNavController

- (NSUInteger)supportedInterfaceOrientations {
    return self.rotationMask;
}

@end
