//
//  YYBRefreshDoneView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshDoneView.h"

@implementation YYBRefreshDoneView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithScrollView:scrollView];
    if (!self) return nil;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _titleLabel.textColor = [UIColor colorWithRed:0.4974 green:0.4974 blue:0.4974 alpha:1.0f];
    _titleLabel.text = @"没有更多了";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    return self;
}

@end
