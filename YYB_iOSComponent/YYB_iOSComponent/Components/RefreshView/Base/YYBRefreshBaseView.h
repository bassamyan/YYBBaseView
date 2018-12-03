//
//  YYBRefreshBaseView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , YYBRefreshStatus) {
    // 初始化状态
    YYBRefreshStatusInitial,
    // 拉动中状态
    YYBRefreshStatusPulling,
    // 刷新状态
    YYBRefreshStatusRefreshing
};

#define YYBRefreshStringify(x) #x
static inline NSString * YYBRefreshStatusString(YYBRefreshStatus status) {
#define YYBCASE(x) case YYBRefreshStatus ## x : return @YYBRefreshStringify(YYBRefreshStatus ## x ## Key);
    switch (status) {
            YYBCASE(Initial);
            YYBCASE(Pulling);
            YYBCASE(Refreshing);
    }
#undef YYBCASE
}

typedef void (^ YYBRefreshStartRefreshHandler)(void);

@interface YYBRefreshBaseView : UIView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
@property (nonatomic,strong,readonly) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets scrollEdgeInsets;


// 拖动的状态
@property (nonatomic) YYBRefreshStatus status;
// 当拉动状态变化时的回调
- (void)statusDidChanged:(YYBRefreshStatus)status;


// 是否允许‘offset’与‘percent’输出 默认为'YES'
@property (nonatomic) BOOL isAllowHandleOffset;
// 拖动的偏移量
@property (nonatomic) CGFloat offset;
// 滚动时回调,percent为滚动距离相较于总高度的百分比
- (void)offsetDidChanged:(CGFloat)offset percent:(CGFloat)percent;

// 偏移量占据控件高度的百分比
// 当status = YYBRefreshStatusInitial 时,该值为0
// 当status = YYBRefreshStatusRefreshing 时,该值为1
@property (nonatomic) CGFloat percent;


// 刷新活动开始前的回调
@property (nonatomic,copy) YYBRefreshStartRefreshHandler startRefreshHandler;
- (void)startRefreshAnimation;
// completionHandler - 动画结束的回调
// 可以在此block中进行reload操作
- (void)endRefreshAnimation;
- (void)endRefreshAnimationWithEndHandler:(void (^)(void))endRefreshHandler;


// 刷新结束后用于重置
- (void)renderOriginalEdgeInsets;
- (void)renderRefreshingStatusEdgeInsets;

@end
