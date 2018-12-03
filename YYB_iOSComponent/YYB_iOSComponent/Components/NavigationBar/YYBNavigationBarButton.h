//
//  YYBNavigationBarButton.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarContainer.h"

@interface YYBNavigationBarButton : YYBNavigationBarContainer

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,copy) void (^ buttonTapedActionHandler)(YYBNavigationBarContainer *view);

@end
