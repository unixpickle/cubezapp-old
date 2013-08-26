//
//  ANImageSyncer.h
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGeneralSyncer.h"
#import "ANImageManager.h"

#import "ANAPICallImageDownload.h"
#import "ANAPIImageDownloadResponse.h"

@class ANImageDownloader;

@protocol ANImageDownloaderDelegate <ANGeneralSyncerDelegate>

- (void)imageDownloader:(ANImageDownloader *)syncer updatedPuzzleImages:(NSArray *)puzzles;

@end

@interface ANImageDownloader : ANGeneralSyncer {
    __weak id<ANImageDownloaderDelegate> delegate;
}

@end
