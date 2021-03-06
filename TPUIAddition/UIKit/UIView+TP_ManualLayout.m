//
//  UIView+TP_ManualLayout.m
//  TPUIAddition
//
//  Created by PengTao on 16/3/28.
//  Copyright © 2016年 CoderTPeng. All rights reserved.
//

#import "UIView+TP_ManualLayout.h"

@implementation UIView (TP_ManualLayout)

// coordinator getters

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}


- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}


- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}


- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (void)setLeft:(CGFloat)left {
    self.x = left;
}


// height
- (void)setHeight:(CGFloat)height {
    CGRect newFrame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = newFrame;
}

- (void)heightEqualToView:(UIView *)view {
    self.height = view.height;
}

// width
- (void)setWidth:(CGFloat)width {
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = newFrame;
}

- (void)widthEqualToView:(UIView *)view {
    self.width = view.width;
}

// center
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (void)centerXEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = floorf(newOrigin.y + top + view.height);
}

- (void)left:(CGFloat)left FromView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x - left - self.width;
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y - bottom - self.height;
}

- (void)right:(CGFloat)right FromView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + right + view.width;
}

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(TPUIScreenType)screenType {
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self top:topValue FromView:view];
}

- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(TPUIScreenType)screenType {
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self left:leftValue FromView:view];
}

- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(TPUIScreenType)screenType {
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottom:bottomValue FromView:view];
}

- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(TPUIScreenType)screenType {
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self right:rightValue FromView:view];
}

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(TPUIScreenType)screenType {
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self topInContainer:topValue shouldResize:shouldResize];
}

- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(TPUIScreenType)screenType {
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self leftInContainer:leftValue shouldResize:shouldResize];
}

- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(TPUIScreenType)screenType {
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottomInContainer:bottomValue shouldResize:shouldResize];
}

- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(TPUIScreenType)screenType {
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self rightInContainer:rightValue shouldResize:shouldResize];
}

- (void)topEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y;
}

- (void)leftEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x;
}

- (void)bottomEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + view.height - self.height;
}

- (void)rightEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + view.width - self.width;
}

// size
- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)sizeEqualToView:(UIView *)view {
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

// imbueset
- (void)fillWidth {
    self.width = self.superview.width;
}

- (void)fillHeight {
    self.height = self.superview.height;
}

- (void)fill {
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

- (UIView *)topSuperView {
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

@end
