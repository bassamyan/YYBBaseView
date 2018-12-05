//
//  YIRefreshViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YIRefreshViewController.h"
#import "YYBRefreshView.h"

@interface YIRefreshViewController ()

@end

@implementation YIRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [self.tableView addRefreshHeaderWithHandler:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshAnimation];
        });
    }];
}


@end
