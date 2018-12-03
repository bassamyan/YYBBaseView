//
//  UIView+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYBAdd)

// 角标
- (void)cornerRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;
- (void)cornerRadius:(CGFloat)radius;

// 截屏
- (UIImage *)snap;

- (void)whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))handler;
- (void)whenTapped:(void (^)(void))handler;
- (void)whenDoubleTapped:(void (^)(void))handler;
- (void)eachSubview:(void (^)(UIView *subview))handler;

@end
