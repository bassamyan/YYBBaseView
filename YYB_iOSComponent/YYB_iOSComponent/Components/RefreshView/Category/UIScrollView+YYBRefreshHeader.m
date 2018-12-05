//
//  UIScrollView+YYBRefreshHeader.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "UIScrollView+YYBRefreshHeader.h"
#import <objc/runtime.h>

static CGFloat const YYBREFRESH_HEADER_HEIGHT = 60;
static char const YYBREFRESH_HEADER_KEY;

@implementation UIScrollView (YYBRefreshHeader)

- (void)addRefreshHeaderWithHandler:(YYBRefreshStartRefreshHandler)startRefreshHandler {
    [self addRefreshHeaderWithClass:NSClassFromString(@"YYBRefreshSpotTopView") handler:startRefreshHandler];
}

- (void)addRefreshHeaderWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler {
    [self addRefreshHeaderWithClass:viewClass handler:startRefreshHandler height:YYBREFRESH_HEADER_HEIGHT];
}

- (void)addRefreshHeaderWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler height:(CGFloat)height {
    [self removeHeaderView];
    
    YYBRefreshHeaderView *view = [[viewClass alloc] initWithScrollView:self];
    
    UIEdgeInsets edgeInsets = self.contentInset;
    CGFloat width = CGRectGetWidth(self.frame) - edgeInsets.left - edgeInsets.right;
    view.frame = CGRectMake(0, -height, width, height);
    view.startRefreshHandler = startRefreshHandler;
    [self addSubview:view];
    
    self.header = view;
    
    [self addObserver:self.header forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self.header forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setHeader:(YYBRefreshHeaderView *)header {
    objc_setAssociatedObject(self, &YYBREFRESH_HEADER_KEY, header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYBRefreshHeaderView *)header {
    return objc_getAssociatedObject(self, &YYBREFRESH_HEADER_KEY);
}

- (void)removeHeaderView {
    self.header.status = YYBRefreshStatusInitial;
    self.header.startRefreshHandler = nil;
    
    if (!self.header) return;
    [self removeObserver:self.header forKeyPath:@"contentOffset"];
    [self removeObserver:self.header forKeyPath:@"contentSize"];
    [self.header removeFromSuperview];
}

@end
