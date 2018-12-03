//
//  UIViewYYBAdd.m
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import "UIView+YYBAdd.h"
#import "UIGestureRecognizer+YYBAdd.h"

@implementation UIView (YYBAdd)

- (void)cornerRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}

- (void)cornerRadius:(CGFloat)radius
{
    [self cornerRadius:radius width:0.0f color:nil];
}

- (UIImage *)snap
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *snapShot = UIGraphicsGetImageFromCurrentImageContext();
    return snapShot;
}

- (void)whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))handler
{
    if (!handler) return;
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer recognizerWithHandler:^(UIGestureRecognizer *gesture) {
        if (gesture.state == UIGestureRecognizerStateRecognized) {
            handler();
        }
    }];
    
    gesture.numberOfTouchesRequired = numberOfTouches;
    gesture.numberOfTapsRequired = numberOfTaps;
    
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;
        
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
        BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    
    [self addGestureRecognizer:gesture];
}

- (void)whenTapped:(void (^)(void))handler
{
    [self whenTouches:1 tapped:1 handler:handler];
}

- (void)whenDoubleTapped:(void (^)(void))handler
{
    [self whenTouches:1 tapped:2 handler:handler];
}

- (void)eachSubview:(void (^)(UIView *subview))handler
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        handler(subview);
    }];
}

@end
