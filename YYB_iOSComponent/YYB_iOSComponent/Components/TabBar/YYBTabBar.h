//
//  YYBTabBar.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYBTabBar;
@class YYBTabBarControl;

@protocol YYBTabBarDelegate <NSObject>

- (NSInteger)numbersOfTabBarControlsInTabBar:(YYBTabBar *)tabBar;
- (YYBTabBarControl *)tabBarControlInTabBar:(YYBTabBar *)tabBar withIndex:(NSInteger)index;

@end

@interface YYBTabBar : UIView

@property (nonatomic,weak) id<YYBTabBarDelegate> delegate;

@property (nonatomic,strong) UIView *contentView;

@end

NS_ASSUME_NONNULL_END
