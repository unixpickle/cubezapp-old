//
//  ANPuzzleScrambler.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ANPuzzleScramblerCallback)(NSError * error, NSString * scramble);

@protocol ANPuzzleScrambler <NSObject>

- (id)generateScramble:(NSInteger)length callback:(ANPuzzleScramblerCallback)callback;
- (void)cancelScramble:(id)aToken;

+ (NSRange)lengthRange;
+ (NSString *)labelForLength:(NSInteger)length;

@end
