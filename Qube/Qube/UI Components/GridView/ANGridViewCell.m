//
//  ANGridViewCell.m
//  GridView
//
//  Created by Alex Nichol on 9/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANGridViewCell.h"
#import "ANGridView.h"

@interface ANGridViewCell (Private)

- (void)beginWiggle;
- (void)cancelWiggle;

@end

@implementation ANGridViewCell

@synthesize item;
@synthesize deleteButton;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame item:(ANGridViewItem *)anItem {
    if ((self = [super initWithFrame:frame])) {
        item = anItem;
        item.frame = self.bounds;
        deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(-11, -11, 22, 22)];
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"]
                                forState:UIControlStateNormal];
        deleteButton.alpha = 0;
        deleteButton.userInteractionEnabled = NO;
        deleteButton.exclusiveTouch = YES;
        [self addSubview:item];
        [self addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(deleteButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        
        self.exclusiveTouch = YES;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect deleteRect = CGRectInset(deleteButton.frame, -20, -20);
    CGRect infoRect = CGRectInset(self.item.infoButton.frame, -20, -20);
    if (!self.item.isEditing) {
        UIView * infoButton = self.item.isFlipside ? self.item.backButton : self.item.infoButton;
        if (CGRectContainsPoint(infoRect, point)) return infoButton;
        return [super hitTest:point withEvent:event];
    } else {
        if (CGRectContainsPoint(deleteRect, point)) return deleteButton;
        return [super hitTest:point withEvent:event];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect deleteRect = CGRectInset(deleteButton.frame, -20, -20);
    CGRect infoRect = CGRectInset(self.item.infoButton.frame, -20, -20);
    CGRect extraFrame = self.item.isEditing ? deleteRect : infoRect;
    CGRect holeFrame = self.item.isEditing ? CGRectMake(self.frame.size.width - 10,
                                                        self.frame.size.height - 10, 10, 10) :
                                             CGRectMake(0, 0, 10, 10);
    if (CGRectContainsPoint(holeFrame, point)) return NO;
    if (CGRectContainsPoint(self.bounds, point)) return YES;
    return CGRectContainsPoint(extraFrame, point);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    item.frame = self.bounds;
}

- (void)setEditing:(BOOL)editing {
    [item setIsEditing:editing];
    if (editing) {
        deleteButton.userInteractionEnabled = YES;
        deleteButton.alpha = 1;
        
        if (!self.isDragging) [self beginWiggle];
    } else {
        deleteButton.userInteractionEnabled = NO;
        deleteButton.alpha = 0;
        [self cancelWiggle];
    }
}

- (void)setDragging:(BOOL)flag {
    dragging = flag;
    if (dragging) {
        [self cancelWiggle];
        self.layer.opacity = 0.9;
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1);
    } else {
        self.layer.opacity = 1;
        self.layer.transform = CATransform3DIdentity;
        if (item.isEditing) {
            [self performSelector:@selector(beginWiggle)
                       withObject:nil
                       afterDelay:[CATransaction animationDuration]];
        }
    }
}

- (BOOL)isDragging {
    return dragging;
}

#pragma mark - Events -

- (void)deleteButtonPressed:(id)sender {
    [delegate gridViewCellDeleted:self];
}

#pragma mark - Private -

- (void)beginWiggle {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.04f;
    
    NSValue * valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue * valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.125;
    animation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:animation forKey:@"wiggle"];
}

- (void)cancelWiggle {
    [self.layer removeAnimationForKey:@"wiggle"];
}

@end
