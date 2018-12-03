//
//  YYBNavigationBarContainer+Create.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarContainer+Create.h"

@implementation YYBNavigationBarContainer (Create)

+ (YYBNavigationBarLabel *)labelWithConfigureHandler:(void (^)(YYBNavigationBarLabel *, UILabel *))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *))tapedActionHandler
{
    YYBNavigationBarLabel *view = [[YYBNavigationBarLabel alloc] init];
    if (configureHandler)
    {
        configureHandler(view,view.label);
    }
    view.tapedActionHandler = tapedActionHandler;
    return view;
}

+ (YYBNavigationBarImageView *)imageViewWithConfigureHandler:(void (^)(YYBNavigationBarImageView *, UIImageView *))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *))tapedActionHandler
{
    YYBNavigationBarImageView *view = [[YYBNavigationBarImageView alloc] init];
    if (configureHandler)
    {
        configureHandler(view,view.imageView);
    }
    view.tapedActionHandler = tapedActionHandler;
    return view;
}

+ (YYBNavigationBarButton *)buttonWithConfigureHandler:(void (^)(YYBNavigationBarButton *, UIButton *))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *))tapedActionHandler
{
    YYBNavigationBarButton *view = [[YYBNavigationBarButton alloc] init];
    if (configureHandler)
    {
        configureHandler(view,view.button);
    }
    view.buttonTapedActionHandler = tapedActionHandler;
    return view;
}

+ (YYBNavigationBarControl *)controlWithConfigureHandler:(void (^)(YYBNavigationBarControl *, UIImageView *, UILabel *))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *))tapedActionHandler
{
    YYBNavigationBarControl *view = [[YYBNavigationBarControl alloc] init];
    if (configureHandler)
    {
        configureHandler(view,view.iconView,view.label);
    }
    view.tapedActionHandler = tapedActionHandler;
    return view;
}

@end
