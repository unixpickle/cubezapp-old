//
//  ANImageUploader.m
//  Qube
//
//  Created by Alex Nichol on 8/26/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANImageUploader.h"

@interface ANImageUploader (Private)

- (void)handleMissing:(NSDictionary *)dict;

@end

@implementation ANImageUploader

- (id)initWithDelegate:(id<ANGeneralSyncerDelegate>)aDel {
    if ((self = [super initWithDelegate:aDel])) {
        ANAPICall * call = [[ANAPICall alloc] initWithAPI:@"image.missing"
                                                   params:@{}];
        [self sendAPICall:call returnSelector:@selector(handleMissing:)];
    }
    return self;
}

- (void)handleMissing:(NSDictionary *)dict {
    NSArray * missing = [dict objectForKey:@"hashes"];
    for (NSData * ident in missing) {
        NSData * localData = [[ANImageManager sharedImageManager] imageDataForHash:ident];
        if (!localData) continue;
        ANAPICallImageUpload * upload = [[ANAPICallImageUpload alloc] initWithHash:ident
                                                                              data:localData];
        [self sendAPICall:upload returnSelector:nil];
    }
}

@end
