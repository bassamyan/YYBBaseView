//
//  YYBRefreshBottomView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshBottomView.h"
#import <Masonry/Masonry.h>

@interface YYBRefreshBottomView ()
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) NSMutableDictionary *stateKeys;

@end
@implementation YYBRefreshBottomView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithScrollView:scrollView];
    if (!self) return nil;
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self _refreshInitialize];
    
    return self;
}

- (void)resetTitle:(NSString *)title status:(YYBRefreshStatus)status {
    if (!title) return;
    [_stateKeys setValue:title forKey:YYBRefreshStatusString(status)];
}

- (void)_refreshInitialize {
    self.isAllowHandleOffset = NO;
    _stateKeys = [[NSMutableDictionary alloc] initWithDictionary:@{YYBRefreshStatusString(YYBRefreshStatusInitial) : BTRV_BOTTOM_INITIALIZE,
                                                                   YYBRefreshStatusString(YYBRefreshStatusPulling) : BTRV_BOTTOM_PULLING,
                                                                   YYBRefreshStatusString(YYBRefreshStatusRefreshing) : BTRV_BOTTOM_REFRESHING}];
    _textLabel.text = [self keyTitleAttachState:self.status];
}

- (void)statusDidChanged:(YYBRefreshStatus)status {
    _textLabel.text = [self keyTitleAttachState:status];
    switch (status) {
        case YYBRefreshStatusInitial: {
            _textLabel.hidden = FALSE;
            [_activityView stopAnimating];
        }
            break;
        case YYBRefreshStatusPulling: {
            
        }
            break;
        case YYBRefreshStatusRefreshing: {
            _textLabel.hidden = TRUE;
            [_activityView startAnimating];
        }
            break;
            
        default:
            break;
    }
}

- (NSString *)keyTitleAttachState:(YYBRefreshStatus)state {
    NSString *key = YYBRefreshStatusString(state);
    if ([_stateKeys.allKeys containsObject:key]) {
        return [_stateKeys objectForKey:key];
    }
    return @"";
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

@end
