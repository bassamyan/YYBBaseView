//
//  YYBNavigationBarButton.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarButton.h"

@implementation YYBNavigationBarButton

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _button = [UIButton new];
    [self addSubview:_button];
    
    [_button addTarget:self action:@selector(buttonActionHandler) forControlEvents:1<<6];
    
    return self;
}

- (void)buttonActionHandler
{
    if (self.buttonTapedActionHandler)
    {
        self.buttonTapedActionHandler(self);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _button.frame = self.bounds;
}

@end
