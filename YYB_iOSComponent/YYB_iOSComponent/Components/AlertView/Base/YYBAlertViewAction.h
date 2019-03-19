//
//  YYBAlertViewAction.h
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYBAlertViewTypedef.h"
#import "YYBAlertPlaceholderTextView.h"

typedef void(^ YYBAlertViewActionBlankHandler)(void);
typedef void(^ YYBAlertViewActionHandler)(NSInteger index);
typedef void(^ YYBAlertViewStringHandler)(NSString *string);

@interface YYBAlertViewAction : NSObject

// 根据不同style激活不同控件
@property (nonatomic,strong,readonly) UILabel *label;
@property (nonatomic,strong,readonly) UIButton *button;
@property (nonatomic,strong,readonly) UITextField *textField;
@property (nonatomic,strong,readonly) YYBAlertPlaceholderTextView *textView;
@property (nonatomic,strong,readonly) UIImageView *imageView;
@property (nonatomic,strong) UIView *view;
@property (nonatomic,strong,readonly) UIActivityIndicatorView *indicator;

@property (nonatomic,copy) YYBAlertViewActionHandler actionHandler;
@property (nonatomic,copy) YYBAlertViewActionBlankHandler actionBlankHandler;
@property (nonatomic,copy) YYBAlertViewStringHandler stringHandler;

// 初始化方法
- (instancetype)initWithStyle:(YYBAlertViewActionStyle)style;
@property (nonatomic,readonly) YYBAlertViewActionStyle style;

@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) UIEdgeInsets margin;

// 控件尺寸
@property (nonatomic) CGSize size;
// 索引,用于回调确定具体响应来源
@property (nonatomic) NSInteger index;

- (UIView *)actionView;
- (CGSize)labelSizeWithMaxWidth:(CGFloat)width;

- (CGSize)actionSizeWithContainerMaxWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;

@end
