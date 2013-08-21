//
//  ANConflict.h
//  Qube
//
//  Created by Alex Nichol on 8/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ANConflictInputSelection,
    ANConflictInputPuzzleName
} ANConflictInput;

@interface ANConflict : NSObject {
    NSArray * options;
}

@property (nonatomic, strong) NSString * returnedInput;

- (NSArray *)options;
- (NSString *)title;
- (ANConflictInput)inputTypeForOption:(int)index;

@end
