//
//  YYBRefreshBaseView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshBaseView.h"

@interface YYBRefreshBaseView ()
@property (nonatomic,copy) void (^ endRefreshHandler)(void);

@end

@implementation YYBRefreshBaseView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithFrame:CGRectZero];
    if (!self) return nil;
    self.backgroundColor = [UIColor clearColor];
    
    _isAllowHandleOffset = YES;
    _scrollView = scrollView;
    _scrollEdgeInsets = scrollView.contentInset;
    
    return self;
}

- (void)startRefreshAnimation {
    self.status = YYBRefreshStatusRefreshing;
}

- (void)endRefreshAnimation {
    [self endRefreshAnimationWithEndHandler:nil];
}

- (void)endRefreshAnimationWithEndHandler:(void (^)(void))endRefreshHandler {
    if (_status != YYBRefreshStatusInitial) {
        self.status = YYBRefreshStatusInitial;
        self.endRefreshHandler = endRefreshHandler;
        
        [UIView animateWithDuration:0.0f animations:^{

        } completion:^(BOOL finished) {
            if (self.endRefreshHandler) {
                self.endRefreshHandler();
                self.endRefreshHandler = nil;
            }
        }];
    }
}

- (void)renderOriginalEdgeInsets {
    
}

- (void)renderRefreshingStatusEdgeInsets {
    
}

- (void)statusDidChanged:(YYBRefreshStatus)status {
    
}

- (void)offsetDidChanged:(CGFloat)offset percent:(CGFloat)percent {
    
}

- (void)setStatus:(YYBRefreshStatus)status {
    if (_status == status) return;
    _status = status;
    
    [self statusDidChanged:status];
    
    switch (status) {
        case YYBRefreshStatusInitial: {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self renderOriginalEdgeInsets];
            } completion:nil];
        }
            break;
        case YYBRefreshStatusPulling: {
            
        }
            break;
        case YYBRefreshStatusRefreshing: {
            if (self.endRefreshHandler == nil) {
                [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self renderRefreshingStatusEdgeInsets];
                } completion:^(BOOL finished) {
                    if (self.startRefreshHandler) {
                        self.startRefreshHandler();
                    }
                }];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
