//
//  YYBTabBarControl.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YYBTabBarControlStyle)
{
    // 两者居中
    YYBTabBarControlStyleCenter,
    // 图片在上,文字在下
    YYBTabBarControlStyleTop,
};

@interface YYBTabBarControl : UIControl

@property (nonatomic) YYBTabBarControlStyle style;

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

NS_ASSUME_NONNULL_END
