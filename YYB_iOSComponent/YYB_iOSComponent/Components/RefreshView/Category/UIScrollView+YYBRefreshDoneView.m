//
//  UIScrollView+YYBRefreshDoneView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "UIScrollView+YYBRefreshDoneView.h"
#import <objc/runtime.h>

static CGFloat const YYBREFRESH_DONE_HEIGHT = 60;
static char const YYBREFRESH_DONE_KEY;

@implementation UIScrollView (YYBRefreshDoneView)

- (void)addRefreshDoneView {
    [self addRefreshDoneViewWithClass:NSClassFromString(@"YYBRefreshDoneView")];
}

- (void)addRefreshDoneViewWithClass:(Class)viewClass {
    [self addRefreshDoneViewWithClass:viewClass height:YYBREFRESH_DONE_HEIGHT];
}

- (void)addRefreshDoneViewWithClass:(Class)viewClass height:(CGFloat)height {
    [self removeDoneView];
    
    YYBRefreshBaseDoneView *view = [[viewClass alloc] initWithScrollView:self];
    UIEdgeInsets edgeInsets = self.contentInset;
    CGFloat width = CGRectGetWidth(self.frame) - edgeInsets.left - edgeInsets.right;
    CGFloat y = self.contentSize.height;
    
    view.frame = CGRectMake(0, y, width, height);
    [self addSubview:view];
    [view renderAnimationEdgeInsets];
    
    self.doneView = view;
    
    [self addObserver:self.doneView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setDoneView:(YYBRefreshBaseDoneView *)doneView {
    objc_setAssociatedObject(self, &YYBREFRESH_DONE_KEY, doneView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYBRefreshBaseDoneView *)doneView {
    return objc_getAssociatedObject(self, &YYBREFRESH_DONE_KEY);
}

- (void)removeDoneView {
    if (self.doneView) {
        [self.doneView renderOriginalEdgeInsets];
        [self.doneView removeFromSuperview];
    }
}

@end
