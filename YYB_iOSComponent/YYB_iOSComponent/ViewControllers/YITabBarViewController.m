//
//  YITabBarViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YITabBarViewController.h"
#import "YYBTabBar.h"

@interface YITabBarViewController ()<YYBTabBarDelegate>
@property (nonatomic,strong) YYBTabBar *tabbar;
@property (nonatomic,strong) NSMutableArray *tabBarControls;

@end

@implementation YITabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *vcs = @[@"YIPushViewController",@"YIAlertViewController",@"YIRefreshViewController"];
    self.viewControllers = [vcs map:^id(NSString *obj, NSInteger index) {
        UIViewController *vc = [[NSClassFromString(obj) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        return nav;
    }];
    
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    
    _tabBarControls = [NSMutableArray new];
    
    YYBTabBarControl *tab1 = [[YYBTabBarControl alloc] init];
    [tab1 setBarButtonImage:[UIImage imageNamed:@"ic_tb_goal_n"] controlState:0];
    [tab1 setBarButtonImage:[UIImage imageNamed:@"ic_tb_goal_s"] controlState:UIControlStateSelected];
    tab1.imageSize = CGSizeMake(20.0f, 20.0f);
    
    YYBTabBarControl *tab2 = [[YYBTabBarControl alloc] init];
    [tab2 setBarButtonImage:[UIImage imageNamed:@"ic_tb_chat_n"] controlState:0];
    [tab2 setBarButtonImage:[UIImage imageNamed:@"ic_tb_chat_s"] controlState:UIControlStateSelected];
    tab2.imageSize = CGSizeMake(35.0f, 35.0f);
    
    YYBTabBarControl *tab3 = [[YYBTabBarControl alloc] init];
    [tab3 setBarButtonImage:[UIImage imageNamed:@"ic_tb_user_n"] controlState:0];
    [tab3 setBarButtonImage:[UIImage imageNamed:@"ic_tb_user_s"] controlState:UIControlStateSelected];
    tab3.imageSize = CGSizeMake(35.0f, 35.0f);
    
    [_tabBarControls addObjectsFromArray:@[tab1,tab2,tab3]];
    
    _tabbar = [[YYBTabBar alloc] init];
    _tabbar.delegate = self;
    _tabbar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:_tabbar];
}

- (void)tabBar:(YYBTabBar *)tabBar didClickedAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

- (NSInteger)numbersOfTabBarControlsInTabBar:(YYBTabBar *)tabBar
{
    return 3;
}

- (YYBTabBarControl *)tabBarControlInTabBar:(YYBTabBar *)tabBar withIndex:(NSInteger)index
{
    return [_tabBarControls objectAtIndex:index];
}

@end
