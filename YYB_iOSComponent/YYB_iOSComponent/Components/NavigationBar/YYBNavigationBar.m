//
//  YYB_iOSComponent.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBar.h"

@interface YYBNavigationBar ()

@end

@implementation YYBNavigationBar
{
    NSDictionary *_defaultTitleAttributes;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    self.clipsToBounds = TRUE;
    
    _leftBarContainers = [NSMutableArray new];
    _rightBarContainers = [NSMutableArray new];
    _defaultTitleAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:16.0f]};
    
    _shadowView = [UIView new];
    _shadowView.backgroundColor = [UIColor clearColor];
    [self addSubview:_shadowView];
    
    _titleBarButton = [YYBNavigationBarLabel new];
    _titleBarButton.label.textAlignment = NSTextAlignmentCenter;
    [_shadowView addSubview:_titleBarButton];
    
    _contentView = [UIImageView new];
    _contentView.userInteractionEnabled = TRUE;
    [_shadowView addSubview:_contentView];
    
    _bottomLayerView = [UIView new];
    [self addSubview:_bottomLayerView];
    
    return self;
}

- (void)setLeftBarContainers:(NSArray *)leftBarContainers
{
    _leftBarContainers = leftBarContainers;
    [self setNeedsLayout];
}

- (void)setRightBarContainers:(NSArray *)rightBarContainers
{
    _rightBarContainers = rightBarContainers;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _shadowView.frame = self.bounds;
    _contentView.frame = _shadowView.bounds;
    _bottomLayerView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5f, CGRectGetWidth(self.frame), 0.5f);
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    if (_titleBarContainer)
    {
        _titleBarButton.frame = CGRectZero;
        
        [_shadowView insertSubview:_titleBarContainer belowSubview:_contentView];
        
        CGSize contentSize = _titleBarContainer.contentSize;
        _titleBarContainer.frame = CGRectMake((width - contentSize.width) / 2 + _titleBarContainer.contentEdgeInsets.left - _titleBarContainer.contentEdgeInsets.right, (height - contentSize.height) / 2 + _titleBarContainer.contentEdgeInsets.top - _titleBarContainer.contentEdgeInsets.bottom, contentSize.width, contentSize.height);
    }
    else
    {
        if (_titleBarContainer) {
            [_titleBarContainer removeFromSuperview];
        }
        _titleBarButton.frame = CGRectMake(+ _titleBarContainer.contentEdgeInsets.left - _titleBarContainer.contentEdgeInsets.right, _titleBarButton.contentEdgeInsets.top - _titleBarButton.contentEdgeInsets.bottom,
                                           width, height);
    }
    
    for (UIView *view in _contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGFloat max_left_width = 0;
    for (NSInteger index = 0; index < _leftBarContainers.count; index ++)
    {
        YYBNavigationBarContainer *view = [_leftBarContainers objectAtIndex:index];
        CGSize contentSize = view.contentSize;
        if (contentSize.height == 0)
        {
            contentSize.height = height;
        }
        view.frame = CGRectMake(max_left_width + view.contentEdgeInsets.left + view.contentEdgeInsets.right,
                                (height - contentSize.height) / 2 - view.contentEdgeInsets.bottom + view.contentEdgeInsets.top,
                                contentSize.width, contentSize.height);
        [_contentView addSubview:view];
        
        max_left_width += contentSize.width + view.contentEdgeInsets.left + view.contentEdgeInsets.right;
    }
    
    CGFloat max_right_width = 0;
    for (NSInteger index = 0; index < _rightBarContainers.count; index ++)
    {
        YYBNavigationBarContainer *view = [_rightBarContainers objectAtIndex:index];
        CGSize contentSize = view.contentSize;
        if (contentSize.height == 0)
        {
            contentSize.height = height;
        }
        view.frame = CGRectMake(width - max_right_width - contentSize.width - view.contentEdgeInsets.left - view.contentEdgeInsets.right,
                                (height - contentSize.height) / 2 - view.contentEdgeInsets.bottom + view.contentEdgeInsets.top,
                                contentSize.width, contentSize.height);
        [_contentView addSubview:view];
        
        max_right_width += contentSize.width + view.contentEdgeInsets.left + view.contentEdgeInsets.right;
    }
}

@end
