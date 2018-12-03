//
//  UIScrollView+YYBRefreshDoneView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBRefreshBaseDoneView.h"

@interface UIScrollView (YYBRefreshDoneView)

@property (nonatomic,strong) YYBRefreshBaseDoneView *doneView;
- (void)removeDoneView;

- (void)addRefreshDoneViewWithClass:(Class)viewClass;
- (void)addRefreshDoneViewWithClass:(Class)viewClass height:(CGFloat)height;

@end
