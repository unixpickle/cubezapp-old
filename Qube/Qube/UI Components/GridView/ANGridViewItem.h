//
//  ANGridViewItem.h
//  GridView
//
//  Created by Alex Nichol on 9/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHoldDelay 0.3

@class ANGridViewItem;
@class ANGridView;

@protocol ANGridViewItemDelegate <NSObject>

- (void)gridViewItemHeld:(ANGridViewItem *)item;
- (void)gridViewItem:(ANGridViewItem *)view draggedOffset:(CGPoint)point;
- (void)gridViewItemReleased:(ANGridViewItem *)item;

@end

@interface ANGridViewItem : UIView {
    UIView * frontside;
    UIView * backside;
    BOOL isFlipside;
    BOOL isEditing;
    
    // used for touch movements
    CGPoint internalDragStart;
    BOOL isDragging;
    BOOL hasMoved;
    NSNumber * currentHoldId;
    
    UIButton * infoButton;
    UIButton * backButton;
    
    BOOL isSendingTouchEvent;
}

@property (readonly) UIView * frontside;
@property (readonly) UIView * backside;
@property (nonatomic, weak) id userInfo;
@property (nonatomic, weak) id<ANGridViewItemDelegate> delegate;
@property (readwrite) BOOL isEditing;
@property (readonly) UIButton * infoButton;
@property (readonly) UIButton * backButton;
@property (nonatomic, weak) ANGridView * gridView;

// swiping
@property (readonly) UIView * currentView;
@property (readonly) BOOL isFlipside;

// initialization
- (id)initWithFrontside:(UIView *)aFrontside
               backside:(UIView *)aBackside;

// flipping
- (void)flipToFrontside;
- (void)flipToBackside;

@end
