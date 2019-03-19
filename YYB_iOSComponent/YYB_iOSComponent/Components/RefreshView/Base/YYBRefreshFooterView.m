//
//  YYBRefreshFooterView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshFooterView.h"

@implementation YYBRefreshFooterView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.status != YYBRefreshStatusRefreshing) {
            CGFloat offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat initial2Pulling = [self initialStatusToPullingStatusOffset];
            CGFloat pulling2Refresh = [self pullingStatusToRefreshingStatusOffset];
            self.offset = offset;
            
            if (offset < initial2Pulling) {
                self.status = YYBRefreshStatusInitial;
                self.percent = 0.0f;
            } else if (offset >= initial2Pulling && offset < pulling2Refresh) {
                self.status = YYBRefreshStatusInitial;
                self.percent = (offset - initial2Pulling) / CGRectGetHeight(self.frame);
            } else if (offset > pulling2Refresh) {
                self.percent = 1.0f;
                if (self.scrollView.isDragging) {
                    self.status = YYBRefreshStatusPulling;
                } else {
                    if (self.status == YYBRefreshStatusPulling) {
                        self.status = YYBRefreshStatusRefreshing;
                    }
                }
            }
            
            if (self.isAllowHandleOffset && [self respondsToSelector:@selector(offsetDidChanged:percent:)]) {
                [self offsetDidChanged:self.offset percent:self.percent];
            }
        }
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat contentHeight = self.scrollView.contentSize.height;
        CGFloat height = CGRectGetHeight(self.scrollView.frame);

        // 如果内容视图的高度比tableView的高度还小, 则隐藏
        self.hidden = contentHeight < height;
        self.frame = CGRectMake(0, contentHeight, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame));
    }
}

- (CGFloat)initialStatusToPullingStatusOffset {
    CGFloat scrollc = self.scrollView.contentSize.height;
    CGFloat scrollh = CGRectGetHeight(self.scrollView.frame);
    if (scrollc < scrollh) return self.scrollEdgeInsets.top;
    return scrollc - scrollh;
}

- (CGFloat)pullingStatusToRefreshingStatusOffset {
    return [self initialStatusToPullingStatusOffset] + CGRectGetHeight(self.frame);
}

- (void)renderOriginalEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = self.scrollEdgeInsets.bottom;
    self.scrollView.contentInset = edgeInsets;
}

- (void)renderRefreshingStatusEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = edgeInsets.bottom + CGRectGetHeight(self.frame);
    self.scrollView.contentInset = edgeInsets;
}

@end
