//
//  Color+HexValue.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#if TARGET_OS_IPHONE
#define ColorClass UIColor
#else
#define ColorClass NSColor
#endif

@interface ColorClass (HexValue)

- (void)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue;

- (NSString *)hexValue;
+ (id)colorWithHexValue:(NSString *)hexValue;

- (NSData *)hexValueData;
+ (id)colorWithHexValueData:(NSData *)data;

@end
