//
//  ANImageManager.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImageManager.h"

@interface ANImageManager (Private)

- (NSString *)imageDirectory;

@end

@implementation ANImageManager

+ (ANImageManager *)sharedImageManager {
    static ANImageManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANImageManager alloc] init];
    });
    return manager;
}

#pragma mark - Listing Hashes -

- (NSArray *)allImageHashes {
    NSMutableArray * hashes = [NSMutableArray array];
    NSArray * listing = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self imageDirectory]
                                                                            error:nil];
    for (NSString * file in listing) {
        if ([file length] != 32) continue;
        NSData * hash = [file dataFromHex];
        if (!hash) continue;
        [hashes addObject:hash];
    }
    return hashes;
}

- (NSArray *)unusedImageHashes {
    NSArray * fsHashes = [self allImageHashes];
    NSMutableArray * unused = [NSMutableArray array];
    for (NSData * hash in fsHashes) {
        NSArray * puzzles = [[ANDataManager sharedDataManager] findPuzzlesWithImageHash:hash];
        if (puzzles.count == 0) [unused addObject:hash];
    }
    return unused;
}

- (void)deleteUnusedImages {
    NSArray * unused = [self unusedImageHashes];
    NSString * basePath = [self imageDirectory];
    for (NSData * hash in unused) {
        NSString * baseName = [hash hexRepresentation];
        NSString * path = [basePath stringByAppendingPathComponent:baseName];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (NSArray *)missingImageHashes {
    NSOrderedSet * puzzles = [ANDataManager sharedDataManager].activeAccount.puzzles;
    NSString * dirPath = [self imageDirectory];
    NSMutableArray * missing = [NSMutableArray array];
    for (ANPuzzle * puzzle in puzzles) {
        NSString * fileName = [puzzle.image hexRepresentation];
        NSString * path = [dirPath stringByAppendingPathComponent:fileName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [missing addObject:puzzle.image];
        }
    }
    return missing;
}

#pragma mark - Registration -

- (NSData *)registerImage:(UIImage *)image {
    return [self registerImageData:UIImagePNGRepresentation(image)];
}

- (NSData *)registerImageData:(NSData *)png {
    NSData * hash = [png md5Hash];
    NSString * path = [[self imageDirectory] stringByAppendingPathComponent:[hash hexRepresentation]];
    [png writeToFile:path atomically:YES];
    return hash;
}

#pragma mark - Lookup -

- (UIImage *)imageForHash:(NSData *)hash {
    if (!hash) return nil;
    NSString * path = [[self imageDirectory] stringByAppendingPathComponent:[hash hexRepresentation]];
    return [[UIImage alloc] initWithContentsOfFile:path];
}

- (NSData *)imageDataForHash:(NSData *)hash {
    if (!hash) return nil;
    NSString * path = [[self imageDirectory] stringByAppendingPathComponent:[hash hexRepresentation]];
    return [NSData dataWithContentsOfFile:path];
}

#pragma mark - Private -

- (NSString *)imageDirectory {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/puzzle_images"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
    }
    return path;
}

@end
