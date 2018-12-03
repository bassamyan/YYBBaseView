//
//  YYBRefreshTopView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/22.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshHeaderView.h"
#import <Masonry/Masonry.h>

static const NSString * BTRV_TOP_INITIALIZE = @"下拉刷新";
static const NSString * BTRV_TOP_PULLING = @"松开刷新";
static const NSString * BTRV_TOP_REFRESHING = @"正在刷新";

@interface YYBRefreshTopView : YYBRefreshHeaderView

- (void)resetTitle:(NSString *)title status:(YYBRefreshStatus)status;

@end
