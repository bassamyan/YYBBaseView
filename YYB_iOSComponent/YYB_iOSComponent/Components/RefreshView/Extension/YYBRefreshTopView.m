//
//  YYBRefreshTopView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshTopView.h"
#import <Masonry/Masonry.h>

@interface YYBRefreshTopView ()
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) NSMutableDictionary *stateKeys;

@end

@implementation YYBRefreshTopView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithScrollView:scrollView];
    if (!self) return nil;
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self _viewInitialize];
    
    return self;
}

- (void)_viewInitialize {
    self.isAllowHandleOffset = NO;
    _stateKeys = [[NSMutableDictionary alloc] initWithDictionary:@{YYBRefreshStatusString(YYBRefreshStatusInitial) : BTRV_TOP_INITIALIZE,
                                                                   YYBRefreshStatusString(YYBRefreshStatusPulling) : BTRV_TOP_PULLING,
                                                                   YYBRefreshStatusString(YYBRefreshStatusRefreshing) : BTRV_TOP_REFRESHING}];
}

- (NSString *)keyTitleAttachState:(YYBRefreshStatus)state {
    NSString *key = YYBRefreshStatusString(state);
    if ([_stateKeys.allKeys containsObject:key]) {
        return [_stateKeys objectForKey:key];
    }
    return @"";
}

- (void)resetTitle:(NSString *)title status:(YYBRefreshStatus)status {
    if (!title) return;
    [_stateKeys setValue:title forKey:YYBRefreshStatusString(status)];
}

- (void)statusDidChanged:(YYBRefreshStatus)status {
    _textLabel.text = [self keyTitleAttachState:status];
    switch (status) {
        case YYBRefreshStatusInitial: {
            [self.activityView stopAnimating];
        }
            break;
        case YYBRefreshStatusPulling: {
            
        }
            break;
        case YYBRefreshStatusRefreshing: {
            [self.activityView startAnimating];
        }
            break;
            
        default:
            break;
    }
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
