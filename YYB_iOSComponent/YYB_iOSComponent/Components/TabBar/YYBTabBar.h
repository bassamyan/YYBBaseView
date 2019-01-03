//
//  YYBTabBar.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBTabBarControl.h"

NS_ASSUME_NONNULL_BEGIN

@class YYBTabBar;

@protocol YYBTabBarDelegate <NSObject>

@required
- (NSInteger)numbersOfTabBarControlsInTabBar:(YYBTabBar *)tabBar;
- (YYBTabBarControl *)tabBarControlInTabBar:(YYBTabBar *)tabBar withIndex:(NSInteger)index;

@optional
- (void)tabBar:(YYBTabBar *)tabBar didClickedAtIndex:(NSInteger)index;

@end

@interface YYBTabBar : UIView

@property (nonatomic,weak) id<YYBTabBarDelegate> delegate;

@property (nonatomic,strong) UIView *contentView;
- (void)reloadContents;

@property (nonatomic) NSInteger initialIndex;

@end

NS_ASSUME_NONNULL_END
