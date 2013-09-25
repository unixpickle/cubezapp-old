//
//  NSSet+OrderedSetFix.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "NSSetOrderedSetFix.h"

@implementation NSSet (OrderedSetFix)

- (BOOL)intersectsSetObject:(id)obj {
    for (id anObj in obj) {
        for (id anotherObj in self) {
            if ([anotherObj isEqual:anObj]) return YES;
        }
    }
    return NO;
}

@end

void ANFixNSSetIntersectsSet() {
    Class c = [NSSet class];
    Method origMethod = class_getInstanceMethod(c, @selector(intersectsSet:));
    Method newMethod = class_getInstanceMethod(c, @selector(intersectsSetObject:));
    if (class_addMethod(c, @selector(intersectsSet:),
                       method_getImplementation(newMethod),
                       method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, @selector(intersectsSetObject:),
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}
