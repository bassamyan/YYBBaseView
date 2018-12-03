//
//  UIView+YYBLayout.h
//  YYBCategory
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (YYBLayout)

- (UIView *)bottomLayerWithColor:(UIColor *)color height:(CGFloat)height edgeInsets:(UIEdgeInsets)edgeInsets;
- (UIView *)topLayerWithColor:(UIColor *)color height:(CGFloat)height edgeInsets:(UIEdgeInsets)edgeInsets;

+ (instancetype)viewWithColor:(UIColor *)color
                    superView:(UIView *)superView
                   constraint:(void(^)(MASConstraintMaker *make))constraint
             configureHandler:(void (^)(UIView *view))configureHandler;

+ (id)viewWithSuperView:(UIView *)superView
             constraint:(void(^)(MASConstraintMaker *make))constraint
       configureHandler:(void (^)(id view))configureHandler;

@end
