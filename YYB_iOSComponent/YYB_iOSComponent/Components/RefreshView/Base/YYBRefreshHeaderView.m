//
//  YYBRefreshHeaderView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshHeaderView.h"

@implementation YYBRefreshHeaderView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.status != YYBRefreshStatusRefreshing) {
            CGFloat offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat pulling2Refresh = [self pullingStatusToRefreshingStatusOffset];
            CGFloat initial2Pulling = [self initialStatusToPullingStatusOffset];
            self.offset = offset;
            
            if (offset >= initial2Pulling) {
                self.status = YYBRefreshStatusInitial;
                self.percent = 0.0f;
            } else if ((offset < initial2Pulling && offset >= pulling2Refresh && self.scrollView.isDragging)
                       || (offset < pulling2Refresh && self.scrollView.isDragging)) {
                self.status = YYBRefreshStatusPulling;
                self.percent = [self percentWithOffsetValue:offset];;
            } else if (offset < pulling2Refresh && !self.scrollView.isDragging) {
                self.status = YYBRefreshStatusRefreshing;
                self.percent = 1.0f;
            }
            
            if (self.isAllowHandleOffset && [self respondsToSelector:@selector(offsetDidChanged:percent:)]) {
                [self offsetDidChanged:self.offset percent:self.percent];
            }
        }
    }
}

- (CGFloat)percentWithOffsetValue:(CGFloat)offset {
    CGFloat rOffset = offset - [self initialStatusToPullingStatusOffset];
    CGFloat pOffset = fabs(rOffset);
    CGFloat percent = pOffset / CGRectGetHeight(self.frame);
    return MIN(percent, 1.0f);
}

- (CGFloat)initialStatusToPullingStatusOffset {
    return - self.scrollEdgeInsets.top;
}

- (CGFloat)pullingStatusToRefreshingStatusOffset {
    return - self.scrollEdgeInsets.top - CGRectGetHeight(self.frame);
}

- (void)renderOriginalEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.top = self.scrollEdgeInsets.top;
    [self.scrollView setContentInset:edgeInsets];
}

- (void)renderRefreshingStatusEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.top += CGRectGetHeight(self.frame);
    [self.scrollView setContentInset:edgeInsets];
}

@end
