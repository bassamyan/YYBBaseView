//
//  UIScrollView+YYBRefreshFooter.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "UIScrollView+YYBRefreshFooter.h"
#import <objc/runtime.h>

static CGFloat const YYBREFESH_FOOTER_HEIGHT = 60;
static char const YYBREFRESH_FOOTER_KEY;

@implementation UIScrollView (YYBRefreshFooter)

- (void)addRefreshFooterWithHandler:(YYBRefreshStartRefreshHandler)startRefreshHandler {
    [self addRefreshFooterWithClass:NSClassFromString(@"YYBRefreshSpotBottomView") handler:startRefreshHandler];
}

- (void)addRefreshFooterWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler {
    [self addRefreshFooterWithClass:[viewClass class] handler:startRefreshHandler height:YYBREFESH_FOOTER_HEIGHT];
}

- (void)addRefreshFooterWithClass:(Class)viewClass handler:(YYBRefreshStartRefreshHandler)startRefreshHandler height:(CGFloat)height {
    [self removeFooterView];
    
    YYBRefreshFooterView *view = [[viewClass alloc] initWithScrollView:self];
    UIEdgeInsets edgeInsets = self.contentInset;
    CGFloat width = CGRectGetWidth(self.frame);

    view.frame = CGRectMake(0, self.contentSize.height, width, height);
    view.startRefreshHandler = startRefreshHandler;
    [self addSubview:view];
    
    self.footer = view;
    
    [self addObserver:self.footer forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self.footer forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setFooter:(YYBRefreshFooterView *)footer {
    objc_setAssociatedObject(self, &YYBREFRESH_FOOTER_KEY, footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYBRefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &YYBREFRESH_FOOTER_KEY);
}

- (void)removeFooterView {
    self.footer.status = YYBRefreshStatusInitial;
    self.footer.startRefreshHandler = nil;
    
    if (!self.footer) return;
    [self removeObserver:self.footer forKeyPath:@"contentOffset"];
    [self removeObserver:self.footer forKeyPath:@"contentSize"];
    [self.footer removeFromSuperview];
}

@end
