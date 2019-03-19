//
//  YYBAlertViewTypedef.h
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#ifndef YYBAlertViewTypedef_h
#define YYBAlertViewTypedef_h

typedef NS_ENUM(NSInteger,YYBAlertViewActionStyle) {
    YYBAlertViewActionStyleUnknow = 0,
    // 文字视图
    YYBAlertViewActionStyleLabel = 1,
    // 按钮视图
    YYBAlertViewActionStyleButton = 2,
    // 输入框视图
    YYBAlertViewActionStyleTextField = 3,
    // 图片视图
    YYBAlertViewActionStyleImageView = 4,
    // 自定义视图
    YYBAlertViewActionStyleCustomView = 5,
    // 选项视图
    YYBAlertViewActionStyleAction = 6,
    // 组件视图
    YYBAlertViewActionStyleContainer = 7,
    // 大输入框视图
    YYBAlertViewActionStyleTextView = 8,
    // 菊花
    YYBAlertViewActionStyleActivityIndicator = 9,
};

typedef NS_ENUM(NSInteger , YYBAlertViewFlexDirection) {
    // 子元素沿着纵向排列
    YYBAlertViewFlexDirectionHorizonal = 0,
    // 子元素沿着横向排列
    YYBAlertViewFlexDirectionVertical = 1,
};

typedef NS_ENUM(NSInteger , YYBAlertViewFlexPosition) {
    // 子元素沿着主轴中心排列
    YYBAlertViewFlexPositionCenter = 0,
    // 子元素沿着主轴起始点排列
    YYBAlertViewFlexPositionStart = 1,
    // 子元素沿着主轴末尾排列
    YYBAlertViewFlexPositionEnd = 2,
    // 子视图均分父视图的宽或者高,baseline在视图中心点
    YYBAlertViewFlexPositionStretch = 3,
};

typedef NS_ENUM(NSInteger , YYBAlertViewContainerPosition) {
    // 主container在中间
    YYBAlertViewContainerPositionCenter = 0,
    // 主container顶部与AlertView底部对齐
    YYBAlertViewContainerPositionBottom = 1,
};

typedef NS_ENUM(NSInteger , YYBAlertViewAnimationStyle) {
    YYBAlertViewAnimationStyleNone,
    // 从中间展现,适用于Dialog
    YYBAlertViewAnimationStyleCenter,
    // 从中间展现,并且会缩放尺寸,适用于弹窗
    YYBAlertViewAnimationStyleCenterShrink,
    // 从底部展现
    YYBAlertViewAnimationStyleBottom,
};


#endif /* YYBAlertViewTypedef_h */
