//
//  ANPuzzle+AttrSetters.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzle+Coding.h"
#import "ANDataManager+Search.h"
#import "ANImageManager.h"

@interface ANPuzzle (AttrSetters)

- (BOOL)isNewPuzzle;
- (void)offlineSetName:(NSString *)name;
- (void)offlineSetIconColor:(NSData *)iconColor;
- (void)offlineSetImage:(NSData *)imageData;
- (void)offlineSetInspectionTime:(double)time;
- (void)offlineSetScramble:(BOOL)scramble;
- (void)offlineSetScrambleLength:(int16_t)len;
- (void)offlineSetShowScramble:(BOOL)show;
- (void)offlineSetShowStats:(BOOL)show;
- (void)offlineSetType:(int16_t)type;

- (void)offlineDelete;

@end
