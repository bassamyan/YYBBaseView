//
//  YYBTabBar.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBTabBar.h"

@interface YYBTabBar ()
@property (nonatomic,strong) YYBTabBarControl *selectedControl;

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
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGFloat itemSize = width / _controls.count;
    for (NSInteger idx = 0; idx < _controls.count; idx ++)
    {
        YYBTabBarControl *control = [_controls objectAtIndex:idx];
        control.frame = CGRectMake(itemSize * idx, 0, itemSize, height);
    }
}

- (void)setDelegate:(id<YYBTabBarDelegate>)delegate
{
    _delegate = delegate;
    [self reloadContents];
}

- (void)reloadContents
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
    
    for (NSInteger idx = 0; idx < controls.count; idx ++)
    {
        YYBTabBarControl *control = [controls objectAtIndex:idx];
        control.tag = idx;
        [control addTarget:self action:@selector(tabBarItemClicked:) forControlEvents:1<<6];
        [_contentView addSubview:control];
        
        if (_initialIndex == idx)
        {
            _selectedControl.selected = FALSE;
            control.selected = TRUE;
            _selectedControl = control;
        }
    }
    
    _controls = controls;
}

- (void)tabBarItemClicked:(YYBTabBarControl *)sender
{
    _selectedControl.selected = FALSE;
    sender.selected = TRUE;
    _selectedControl = sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didClickedAtIndex:)])
    {
        [self.delegate tabBar:self didClickedAtIndex:sender.tag];
    }
}

@end
