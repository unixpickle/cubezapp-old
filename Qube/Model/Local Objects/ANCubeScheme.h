//
//  ANCubeScheme.h
//  Qube
//
//  Created by Alex Nichol on 8/31/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBEncodeObjC.h"
#import "KBDecodeObjC.h"

@interface ANCubeScheme : NSObject

@property (readwrite) double cornerRadius;
@property (readwrite) double edgeRadius;
@property (readwrite) double baseRadius;
@property (readwrite) double vectorX, vectorY, vectorZ, angle;
@property (nonatomic, retain) NSArray * faceColors;

- (id)initWithData:(NSData *)data;
- (NSData *)encode;

@end
