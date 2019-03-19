//
//  YYBViewController.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "YYBNavigationBar.h"
#import "UIColor+YYBAdd.h"
#import "NSString+YYBAdd.h"
#import "UIDevice+YYBAdd.h"

@interface YYBViewController : UIViewController

@property (nonatomic,strong,readonly) YYBNavigationBar *navigationBar;

/**
 为了保证Navigationbar处于顶层
 Navigationbar在viewDidLoad方法调用完成后才会加载,所以需要在此方法中才能添加按钮
 */
- (void)configureNavigationView;

- (CGFloat)heightForNavigationBar;
- (CGRect)frameForNavigarionBar;
- (NSString *)titleForNavigationBar;

@property (nonatomic,strong,readonly) YYBNavigationBarControl *navigationBackBarButton;
- (BOOL)navigationBackBarButtonHandler;

@property (nonatomic) BOOL isPreferNavigationBarHidden;
@property (nonatomic) BOOL isPreferBackNavigationButtonHidden;

// 默认子视图居中显示
// 由于x系列的设备顶部的原因,子视图需要在navigationbar的偏移距离
- (CGFloat)topOffset;
- (void)configureNavigationBackBarButtonWithContainer:(YYBNavigationBarControl *)container;
- (void)configureNavigationTitleBarButtonWithContainer:(YYBNavigationBarLabel *)container;
- (UIColor *)navigationBarBackgroundColor;

@end
