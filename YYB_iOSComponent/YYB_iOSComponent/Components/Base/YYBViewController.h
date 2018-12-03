//
//  YYBViewController.h
//  SavingPot365
//
//  Created by Aokura on 2018/7/4.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
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
- (NSString *)titleForNavigationBar;

@property (nonatomic,strong,readonly) YYBNavigationBarControl *navigationBackBarButton;
- (BOOL)navigationBackBarButtonHandler;

@property (nonatomic) BOOL isPreferNavigationBarHidden;
@property (nonatomic) BOOL isPreferBackNavigationButtonHidden;

@end
