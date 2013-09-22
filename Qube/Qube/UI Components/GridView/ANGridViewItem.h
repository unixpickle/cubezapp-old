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

@protocol ANBasicTouchHandler <NSObject>

- (void)touchBegan:(CGPoint)localPoint;
- (void)touchMoved:(CGPoint)localPoint;
- (void)touchEnded:(CGPoint)localPoint;
- (void)touchCancelled:(CGPoint)localPoint;

@end

@protocol ANGridViewItemDelegate <NSObject>

- (void)gridViewItemHeld:(ANGridViewItem *)item;
- (void)gridViewItem:(ANGridViewItem *)view draggedOffset:(CGPoint)point;
- (void)gridViewItemReleased:(ANGridViewItem *)item;

@end

@interface ANGridViewItem : UIView {
    UIView<ANBasicTouchHandler> * frontside;
    UIView<ANBasicTouchHandler> * backside;
    BOOL isFlipside;
    BOOL isEditing;
    
    // used for touch movements
    CGPoint internalDragStart;
    BOOL isDragging;
    BOOL hasMoved;
    NSNumber * currentHoldId;
    
    UIButton * infoButton;
    UIButton * backButton;
}

@property (readonly) UIView<ANBasicTouchHandler> * frontside;
@property (readonly) UIView<ANBasicTouchHandler> * backside;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, weak) id<ANGridViewItemDelegate> delegate;
@property (readwrite) BOOL isEditing;

// swiping
@property (readonly) UIView<ANBasicTouchHandler> * currentView;
@property (readonly) BOOL isFlipside;

// initialization
- (id)initWithFrontside:(UIView<ANBasicTouchHandler> *)aFrontside
               backside:(UIView<ANBasicTouchHandler> *)aBackside;

// flipping
- (void)flipToFrontside;
- (void)flipToBackside;

@end
