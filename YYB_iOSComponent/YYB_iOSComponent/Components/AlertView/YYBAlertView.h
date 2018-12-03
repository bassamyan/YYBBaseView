//
//  YYBAlertView.h
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBAlertViewAction.h"
#import "YYBAlertViewContainer.h"
#import "UIView+Responder.h"

@class YYBAlertView;

@protocol YYBAlertViewDelegate <NSObject>

- (CGRect)alertView:(YYBAlertView *)alertView containerRectsWithIndex:(NSInteger)index
          container:(YYBAlertViewContainer *)container;

- (BOOL)alertView:(YYBAlertView *)alertView showContainerAtIndex:(NSInteger)index
        container:(YYBAlertViewContainer *)container;

- (BOOL)alertView:(YYBAlertView *)alertView closeContainerWithIndex:(NSInteger)index
        container:(YYBAlertViewContainer *)container removeSubviewsHandler:(void(^)(void))removeSubviewsHandler;

- (BOOL)alertView:(YYBAlertView *)alertView closeAllContainersWithRemoveSubviewsHandler:(void(^)(void))removeSubviewsHandler;

@end

@interface YYBAlertView : UIView

@property (nonatomic,weak) id<YYBAlertViewDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *containers;
@property (nonatomic) NSInteger visibleContainerIndex;

@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UIView *contentView;
- (void)removeContentTapedHandler;

@property (nonatomic,copy) CGRect (^ createRectHandler)(NSInteger index, YYBAlertViewContainer *container);
@property (nonatomic,copy) BOOL (^ showContainerHandler)(NSInteger index, YYBAlertViewContainer *container);
@property (nonatomic,copy) BOOL (^ closeContainerHandler)(NSInteger index, YYBAlertViewContainer *container, void(^ removeSubviewsHandler)(void));
@property (nonatomic,copy) void (^ closeAllContainersHandler)(void(^ removeSubviewsHandler)(void));

// 自动取消视图的时间
// 默认为0秒
@property (nonatomic) NSTimeInterval autoHideTimeInterval;

// 是否自身视图以结果尺寸进行再次约束
// 默认是视图尺寸都是占据整个被加载视图的尺寸进行加载
// 仅只有一个container的时候有效
@property (nonatomic,assign) BOOL isConstraintedWithContainer;

// 是否使用键盘监听
// 如果使用必须设置为YES
@property (nonatomic) BOOL isUsingKeyboardNotification;
// 是否使用默认方式对键盘监听进行视图偏移
@property (nonatomic) BOOL isAutoControlKeyboardNotification;
// 如果不采用默认的对键盘监听的视图偏移方式, 所使用的自定义偏移距离, 该距离是对应responder底部与键盘顶部的间距
@property (nonatomic,copy) CGFloat (^ offsetOfContainerToKeyboard)(NSInteger containerIndex);

// 是否点击背景视图以取消整个视图
// 如果有键盘响应者,则会先取消响应,再次点击后才会取消视图
@property (nonatomic) BOOL isCloseAlertViewWhenTapedBackgroundView;
// 回收响应者键盘
- (void)resignKeyboardResponder;


// 添加一个子单元元素
- (void)addContainerViewWithHandler:(void(^)(YYBAlertViewContainer *container))handler;

- (void)showContainerAtIndex:(NSInteger)index;
- (void)closeContainerAtIndex:(NSInteger)index;

- (void)showAlertView;
- (void)showAlertViewOnKeyWindow;
- (void)showAlertViewOnKeyboardWindow;
- (void)closeAlertView;

@end
