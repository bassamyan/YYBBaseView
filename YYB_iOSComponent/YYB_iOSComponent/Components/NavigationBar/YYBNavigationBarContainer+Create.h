//
//  YYBNavigationBarContainer+Create.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarContainer.h"
#import "YYBNavigationBarImageView.h"
#import "YYBNavigationBarLabel.h"
#import "YYBNavigationBarButton.h"
#import "YYBNavigationBarControl.h"

@interface YYBNavigationBarContainer (Create)

+ (YYBNavigationBarLabel *)labelWithConfigureHandler:(void (^)(YYBNavigationBarLabel *container, UILabel *view))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *view))tapedActionHandler;

+ (YYBNavigationBarImageView *)imageViewWithConfigureHandler:(void (^)(YYBNavigationBarImageView *container, UIImageView *view))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *container))tapedActionHandler;

+ (YYBNavigationBarButton *)buttonWithConfigureHandler:(void (^)(YYBNavigationBarButton *container, UIButton *view))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *view))tapedActionHandler;

+ (YYBNavigationBarControl *)controlWithConfigureHandler:(void (^)(YYBNavigationBarControl *container, UIImageView *iconView, UILabel *label))configureHandler tapedActionHandler:(void (^)(YYBNavigationBarContainer *view))tapedActionHandler;

@end
