//
//  ANImageSyncer.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImageDownloader.h"

@interface ANImageDownloader (Private)

- (void)completionCallback;
- (void)handleDownloaded:(NSDictionary *)response;

@end

@implementation ANImageDownloader

- (id)initWithDelegate:(id<ANImageDownloaderDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        delegate = aDel;
        
        NSArray * missing = [[ANImageManager sharedImageManager] missingImageHashes];
        for (NSData * hash in missing) {
            ANAPICallImageDownload * download = [[ANAPICallImageDownload alloc] initWithHash:hash];
            [self sendAPICall:download returnSelector:@selector(handleDownloaded:)];
        }
        
        // sometimes there will be nothing to do, in which case we will
        // simply send zero requests and callback on the next iteration of
        // the runloop
        if ([missing count] == 0) {
            [self performSelector:@selector(completionCallback)
                       withObject:nil afterDelay:0];
        }
    }
    return self;
}

- (void)completionCallback {
    [self.generalDelegate generalSyncerCompleted:self];
}

- (void)handleDownloaded:(NSDictionary *)response {
    ANAPIImageDownloadResponse * resp = [[ANAPIImageDownloadResponse alloc] initWithDictionary:response];
    if (!resp.data) return;
    NSData * hash = [[ANImageManager sharedImageManager] registerImageData:resp.data];
    NSAssert([hash isEqualToData:resp.hash], @"Hashes should be the same on both ends");
    NSArray * puzzles = [[ANDataManager sharedDataManager] findPuzzlesWithImageHash:hash];
    [delegate imageDownloader:self updatedPuzzleImages:puzzles];
}

@end
