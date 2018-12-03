//
//  YYBNavigationBarControl.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarContainer.h"

typedef NS_ENUM(NSInteger,YYBNavigationBarControlStyle)
{
    // 两者居中
    YYBNavigationBarControlStyleCenter,
    // 图片在上,文字在下
    YYBNavigationBarControlStyleTop,
    // 图片在下,文字在上
    YYBNavigationBarControlStyleBottom,
    // 图片在左,文字在右
    YYBNavigationBarControlStyleLeft,
    // 图片在右,文字在左
    YYBNavigationBarControlStyleRight,
};

@interface YYBNavigationBarControl : YYBNavigationBarContainer

@property (nonatomic) YYBNavigationBarControlStyle style;

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *label;

@property (nonatomic) UIEdgeInsets labelEdgeInsets, iconEdgeInsets;
@property (nonatomic) CGSize imageSize;

@property (nonatomic,readonly) UIControlState controlState;

- (void)setBarButtonTitle:(NSString *)title controlState:(UIControlState)state;
- (void)setBarButtonTextColor:(UIColor *)textColor controlState:(UIControlState)state;
- (void)setBarButtonTextFont:(UIFont *)textFont controlState:(UIControlState)state;
- (void)setBarButtonImage:(UIImage *)image controlState:(UIControlState)state;

@end
