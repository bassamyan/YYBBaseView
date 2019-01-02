//
//  YYBTabBar.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBTabBar.h"

@interface YYBTabBar ()

@end

@implementation YYBTabBar
{
    NSInteger _selectedIndex;
    NSMutableArray *_controls;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
}

- (void)setDelegate:(id<YYBTabBarDelegate>)delegate
{
    _delegate = delegate;
    [self _reloadContents];
}

- (void)_reloadContents
{
    NSMutableArray *controls = [NSMutableArray new];
    NSInteger count = [_delegate numbersOfTabBarControlsInTabBar:self];
    if (count > 0)
    {
        for (NSInteger idx = 0; idx < count; idx ++)
        {
            YYBTabBarControl *control = [_delegate tabBarControlInTabBar:self withIndex:idx];
            [controls addObject:control];
        }
    }
    
    for (UIView *subView in _contentView.subviews)
    {
        [subView removeFromSuperview];
    }
}

@end
