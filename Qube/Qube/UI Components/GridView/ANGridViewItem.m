//
//  ANGridViewItem.m
//  GridView
//
//  Created by Alex Nichol on 9/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGridViewItem.h"
#import "ANGridView.h"

@interface ANGridViewItem (Private)

- (void)resetTouchContext;
- (void)checkForHold:(NSNumber *)anId;

@end

@implementation ANGridViewItem

@synthesize frontside;
@synthesize backside;
@synthesize userInfo;
@synthesize delegate;
@synthesize isFlipside;
@synthesize infoButton;
@synthesize backButton;
@synthesize gridView;

- (UIView *)currentView {
    if (isFlipside) return backside;
    return frontside;
}

- (BOOL)isEditing {
    return isEditing;
}

- (void)setIsEditing:(BOOL)flag {
    isEditing = flag;
    if (isEditing && isFlipside) {
        [self flipToFrontside];
    }
    [infoButton setUserInteractionEnabled:!flag];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [infoButton setAlpha:(flag ? 0 : 1)];
                     }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    frontside.frame = self.bounds;
    backside.frame = self.bounds;
    infoButton.center = CGPointMake(frontside.frame.size.width - 20,
                                    frontside.frame.size.height - 20);
    backButton.center = CGPointMake(backside.frame.size.width - 20,
                                    backside.frame.size.height - 20);
}

// initialization
- (id)initWithFrontside:(UIView *)aFrontside
               backside:(UIView *)aBackside {
    
    NSAssert(CGRectEqualToRect(aFrontside.bounds, aBackside.bounds),
             @"frontside and backside must be equal in size");
    if ((self = [super initWithFrame:aFrontside.bounds])) {
        //self.clipsToBounds = YES;
        frontside = aFrontside;
        backside = aBackside;
        
        frontside.frame = frontside.bounds;
        backside.frame = backside.bounds;
        [self addSubview:frontside];
        
        self.multipleTouchEnabled = NO;
        self.exclusiveTouch = YES;
        
        infoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        
        [infoButton setBackgroundImage:[UIImage imageNamed:@"i"]
                              forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"i_dark"]
                              forState:UIControlStateNormal];
        
        infoButton.center = CGPointMake(frontside.frame.size.width - 20,
                                        frontside.frame.size.height - 20);
        backButton.center = CGPointMake(backside.frame.size.width - 20,
                                        backside.frame.size.height - 20);
        
        [infoButton addTarget:self
                       action:@selector(flipToBackside)
             forControlEvents:UIControlEventTouchUpInside];
        [backButton addTarget:self
                       action:@selector(flipToFrontside)
             forControlEvents:UIControlEventTouchUpInside];
        
        [frontside addSubview:infoButton];
        [backside addSubview:backButton];
    }
    
    return self;
}

#pragma mark - Flipping -

- (void)flipToFrontside {
    if (!isFlipside) return;
    isFlipside = NO;
    CATransition * animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:0.5];
    animation.type = @"flip";
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1.0;
    animation.startProgress = 0.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setRemovedOnCompletion:YES];
    [self.layer addAnimation:animation forKey:@"pageUnCurlAnimation"];
    [backside removeFromSuperview];
}

- (void)flipToBackside {
    NSAssert(!isEditing, @"Cannot show backside while editing");
    if (isFlipside) return;
    isFlipside = YES;
    CATransition * animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:0.5];
    animation.type = @"flip";
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1.0;
    animation.startProgress = 0.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setRemovedOnCompletion:YES];
    
    [self.layer addAnimation:animation forKey:@"pageUnCurlAnimation"];
    [self addSubview:backside];
    
    for (ANGridViewItem * item in self.gridView.items) {
        if (item != self) {
            [item performSelector:@selector(flipToFrontside)
                       withObject:nil afterDelay:0.1];
        }
    }
}

#pragma mark - Handling Touches -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isSendingTouchEvent) return;
    [self resetTouchContext];
    CGPoint localPoint = [[touches anyObject] locationInView:self];
    internalDragStart = localPoint;
    if (!isFlipside) {
        currentHoldId = [NSNumber numberWithUnsignedLong:arc4random()];
        [self performSelector:@selector(checkForHold:)
                   withObject:currentHoldId
                   afterDelay:(isEditing ? 0.0 : kHoldDelay)];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isSendingTouchEvent) return;
    CGPoint point = [[touches anyObject] locationInView:self];
    
    // throw out small movements
    if (!isDragging && !hasMoved) {
        // check if they really moved that far
        CGFloat distance = sqrt(pow(point.x - internalDragStart.x, 2) + pow(point.y - internalDragStart.y, 2));
        if (distance < 7) {
            return;
        }
    }

    currentHoldId = nil;
    if (isDragging) {
        CGFloat offX = point.x - internalDragStart.x;
        CGFloat offY = point.y - internalDragStart.y;
        CGPoint newCenter = CGPointMake(offX, offY);
        [self.delegate gridViewItem:self draggedOffset:newCenter];
    } else {
        isSendingTouchEvent = YES;
        if (!hasMoved) {
            hasMoved = YES;
            [self.currentView touchesBegan:touches withEvent:event];
        }
        [self.currentView touchesMoved:touches withEvent:event];
        isSendingTouchEvent = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isSendingTouchEvent) return;
    currentHoldId = nil;
    if (isDragging) {
        [self.delegate gridViewItemReleased:self];
    } else {
        isSendingTouchEvent = YES;
        if (!hasMoved) {
            [self.currentView touchesBegan:touches withEvent:event];
        }
        [self.currentView touchesEnded:touches withEvent:event];
        isSendingTouchEvent = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isSendingTouchEvent) return;
    currentHoldId = nil;
    if (isDragging) {
        [self.delegate gridViewItemReleased:self];
    } else {
        isSendingTouchEvent = YES;
        if (hasMoved) {
            [self.currentView touchesCancelled:touches withEvent:event];
        }
        isSendingTouchEvent = NO;
    }
}

#pragma mark Private

- (void)resetTouchContext {
    isDragging = NO;
    hasMoved = NO;
}

- (void)checkForHold:(NSNumber *)anId {
    if ([currentHoldId isEqualToNumber:anId]) {
        // we have a hold event
        [self.delegate gridViewItemHeld:self];
        isDragging = YES;
    }
}

@end
