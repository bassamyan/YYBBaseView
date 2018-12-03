//
//  UIScrollView+YYBRefreshHeader.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBRefreshBaseView.h"
#import "YYBRefreshHeaderView.h"
#import "YYBRefreshTopView.h"

@interface UIScrollView (YYBRefreshHeader)

@property (nonatomic,strong) YYBRefreshHeaderView *header;
- (void)removeHeaderView;

- (void)addRefreshHeaderWithHandler:(YYBRefreshStartRefreshHandler)startRefreshHandler;
- (void)addRefreshHeaderWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler;
- (void)addRefreshHeaderWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler height:(CGFloat)height;

@end
