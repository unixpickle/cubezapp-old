//
//  NSSet+OrderedSetFix.h
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

@interface NSSet (OrderedSetFix)

- (BOOL)intersectsSetObject:(id)obj;

@end

void ANFixNSSetIntersectsSet();
