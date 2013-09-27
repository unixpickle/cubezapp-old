//
//  ANImageManager.h
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDataManager+Search.h"
#import "NSString+Hex.h"
#import "NSData+Hex.h"
#import "NSData+MD5.h"

@interface ANImageManager : NSObject

@property (nonatomic, weak) ANPuzzle * editingPuzzle;

+ (ANImageManager *)sharedImageManager;

- (NSArray *)allImageHashes;
- (NSArray *)unusedImageHashes;
- (void)deleteUnusedImages;

- (NSArray *)missingImageHashes;

- (NSData *)registerImage:(UIImage *)image;
- (NSData *)registerImageData:(NSData *)png;
- (UIImage *)imageForHash:(NSData *)hash;
- (NSData *)imageDataForHash:(NSData *)hash;

@end
