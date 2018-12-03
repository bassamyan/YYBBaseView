//
//  YYBAlertViewContainer.h
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBAlertViewAction.h"
#import "YYBAlertViewTypedef.h"
#import "YYBAlertPlaceholderTextView.h"

@interface YYBAlertViewContainer : UIView

// 层级结构如下所示
@property (nonatomic,strong,readonly) UIView *shadowView;
@property (nonatomic,strong,readonly) UIImageView *contentView;
@property (nonatomic,strong,readonly) UIScrollView *scrollView;

@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,assign) CGSize contentSizeWithActions;
@property (nonatomic,assign) UIEdgeInsets padding;
@property (nonatomic,assign) UIEdgeInsets margin;

@property (nonatomic,assign) CGFloat minimalWidth;
@property (nonatomic,assign) CGFloat maximalWidth;
@property (nonatomic,assign) CGFloat minimalHeight;
@property (nonatomic,assign) CGFloat maximalHeight;

// 初始化方法 默认为纵向
// 子视图排列方式
- (YYBAlertViewContainer *)initWithFlexDirection:(YYBAlertViewFlexDirection)direction;

@property (nonatomic,assign) YYBAlertViewFlexDirection flexDirection;
@property (nonatomic,assign) YYBAlertViewFlexPosition flexPosition;

// 视图间距,仅当flexPosition为YYBAlertViewFlexPositionStretch时候有效
// 由于父视图为流式布局,该属性对顶级父视图无效,仅对当前视图的子container有效
@property (nonatomic,assign) CGFloat stretchValue;

// 存放响应按钮的视图
// 该属性中无对应的相同子视图,为nil
@property (nonatomic,strong,readonly) YYBAlertViewContainer *actionsContainer;
- (void)removeContainerContentTapedHandler;

// 键盘响应者
// 如果没有则为nil
- (UIView *)keyboardResponder;

// 添加输入视图
- (void)addLabelWithHandler:(void(^)(YYBAlertViewAction *action, UILabel *label))handler;
// 添加一个图片视图
- (void)addIconViewWithHandler:(void(^)(YYBAlertViewAction *action, UIImageView *imageView))handler;
// 添加一个按钮视图
- (void)addButtonWithHandler:(void(^)(YYBAlertViewAction *action, UIButton *button))handler tapedOnHandler:(void(^)(void))tapedOnHandler;
// 添加一个输入框视图
- (void)addTextFieldWithHandler:(void(^)(YYBAlertViewAction *action, UITextField *textField))handler editingChangedHandler:(void(^)(NSString *string))editHandler;
// 添加一个输入框视图
- (void)addTextViewWithHandler:(void(^)(YYBAlertViewAction *action, YYBAlertPlaceholderTextView *textView))handler editingChangedHandler:(void(^)(NSString *string))editHandler;
// 添加一个自定义视图
- (void)addCustomView:(UIView *)customView configureHandler:(void(^)(YYBAlertViewAction *action, UIView *view))handler;
// 添加选项按钮
- (void)addActionWithHandler:(void(^)(YYBAlertViewAction *action, UIButton *button))handler tapedOnHandler:(void(^)(NSInteger index))tapedOnHandler;
// 添加等待视图
- (void)addActivityIndicatorWithHandler:(void(^)(YYBAlertViewAction *action, UIActivityIndicatorView *view))handler;
// 添加一个子单元元素
- (void)addContainerViewWithHandler:(void(^)(YYBAlertViewContainer *container))handler;

- (void)createActionViews;

@end
