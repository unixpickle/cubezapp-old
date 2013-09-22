//
//  ANAutoscrollView.m
//  GridView
//
//  Created by Alex Nichol on 9/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAutoscrollView.h"

@interface ANAutoscrollView (Private)

- (void)timerTicked;

@end

@implementation ANAutoscrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Context -

- (void)beginContextForView:(UIView *)movingView {
    contextView = movingView;
}

- (void)contextUpdate {
    CGRect frame = [self scrollRectToView:contextView.frame];
    if (frame.origin.y < 0) {
        velocity = frame.origin.y / 20;
    } else if (CGRectGetMaxY(frame) > self.frame.size.height) {
        velocity = (CGRectGetMaxY(frame) - self.frame.size.height) / 20;
    } else {
        [contextTimer invalidate];
        contextTimer = nil;
        return;
    }
    if (!contextTimer) {
        contextTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                        target:self
                                                      selector:@selector(timerTicked)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

- (void)endContext {
    contextView = nil;
    [contextTimer invalidate];
    contextTimer = nil;
}

#pragma mark - Translation -

- (CGRect)scrollRectToView:(CGRect)r {
    CGRect viewRect = r;
    viewRect.origin.y += self.frame.origin.y;
    viewRect.origin.x += self.frame.origin.x;
    viewRect.origin.y -= self.contentOffset.y;
    viewRect.origin.x -= self.contentOffset.x;
    return viewRect;
}

- (CGRect)viewRectToScroll:(CGRect)r {
    CGRect scrollRect = r;
    scrollRect.origin.y -= self.frame.origin.y;
    scrollRect.origin.x -= self.frame.origin.x;
    scrollRect.origin.y += self.contentOffset.y;
    scrollRect.origin.x += self.contentOffset.x;
    return scrollRect;
}

#pragma mark - Private -

- (void)timerTicked {
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y += velocity;
    if (contentOffset.y < 0) {
        contentOffset.y = 0;
        [contextTimer invalidate];
        contextTimer = nil;
    } else if (contentOffset.y > self.contentSize.height - self.frame.size.height) {
        contentOffset.y = self.contentSize.height - self.frame.size.height;
        [contextTimer invalidate];
        contextTimer = nil;
    }
    CGFloat yAdded = contentOffset.y - self.contentOffset.y;
    self.contentOffset = contentOffset;
    
    // move the frame
    CGPoint center = contextView.center;
    center.y += yAdded;
    contextView.center = center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
