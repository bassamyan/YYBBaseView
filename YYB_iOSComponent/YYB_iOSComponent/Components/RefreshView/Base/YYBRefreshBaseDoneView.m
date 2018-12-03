//
//  YYBRefreshBaseDoneView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/3.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshBaseDoneView.h"

@implementation YYBRefreshBaseDoneView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (!self) return nil;
    self.backgroundColor = [UIColor clearColor];
    
    _scrollView = scrollView;
    _scrollEdgeInsets = scrollView.contentInset;
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat y = self.scrollView.contentSize.height;
        [self setFrame:CGRectMake(0, y,
                                  CGRectGetWidth(self.scrollView.frame) - self.scrollEdgeInsets.left - self.scrollEdgeInsets.right,
                                  CGRectGetHeight(self.frame))];
    }
}

- (void)renderOriginalEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = self.scrollEdgeInsets.bottom;
    [self.scrollView setContentInset:edgeInsets];
}

- (void)renderAnimationEdgeInsets {
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom += CGRectGetHeight(self.frame);
    [self.scrollView setContentInset:edgeInsets];
}

@end
