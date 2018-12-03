//
//  UIView+YYBLayout.m
//  YYBCategory
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import "UIView+YYBLayout.h"

@implementation UIView (YYBLayout)

- (UIView *)bottomLayerWithColor:(UIColor *)color height:(CGFloat)height edgeInsets:(UIEdgeInsets)edgeInsets {
    UIView *view = [UIView new];
    if (color) {
        view.backgroundColor = color;
    } else {
        view.backgroundColor = [UIColor lightGrayColor];
    }
    
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(edgeInsets.left);
        make.right.equalTo(self).offset(-edgeInsets.right);
        make.bottom.equalTo(self).offset(-edgeInsets.bottom);
        make.height.mas_equalTo(height);
    }];
    return view;
}

+ (id)viewWithSuperView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint configureHandler:(void (^)(id))configureHandler {
    id view = [[[self class] alloc] init];
    if (superView) {
        [superView addSubview:view];
    }
    if (constraint) {
        [view mas_makeConstraints:constraint];
    }
    if (configureHandler) {
        configureHandler(view);
    }
    return view;
}

- (UIView *)topLayerWithColor:(UIColor *)color height:(CGFloat)height edgeInsets:(UIEdgeInsets)edgeInsets {
    UIView *view = [UIView new];
    if (color) {
        view.backgroundColor = color;
    } else {
        view.backgroundColor = [UIColor lightGrayColor];
    }
    
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(edgeInsets.left);
        make.right.equalTo(self).offset(-edgeInsets.right);
        make.top.equalTo(self).offset(edgeInsets.top);
        make.height.mas_equalTo(height);
    }];
    return view;
}

+ (instancetype)viewWithColor:(UIColor *)color superView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint configureHandler:(void (^)(UIView *))configureHandler {
    UIView *view = [[[self class] alloc] init];
    if (superView) {
        [superView addSubview:view];
        
        if (color) {
            view.backgroundColor = color;
        }
        if (constraint) {
            [view mas_makeConstraints:constraint];
        }
        if (configureHandler) {
            configureHandler(view);
        }
    }
    return view;
}

@end
