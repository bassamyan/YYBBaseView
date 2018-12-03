//
//  YYBNavigationBarLabel.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarLabel.h"

@implementation YYBNavigationBarLabel

- (CGSize)contentSize
{
    [_label sizeToFit];
    return _label.frame.size;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _label = [UILabel new];
    [self addSubview:_label];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.bounds;
}

@end
