//
//  UITableView+YYBLayout.m
//  SavingPot365
//
//  Created by Sniper on 2018/9/24.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "UITableView+YYBLayout.h"

@implementation UITableView (YYBLayout)

+ (UITableView *)tableViewWithDelagateHandler:(id)delegeteHandler superView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint registerClassNames:(NSArray *)registerClassNames configureHandler:(void (^)(UITableView *))configureHandler {
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    view.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (registerClassNames && registerClassNames.count > 0) {
        for (NSString *className in registerClassNames) {
            Class class = NSClassFromString(className);
            if (class) {
                [view registerClass:class forCellReuseIdentifier:className];
            }
        }
    }
    if (delegeteHandler) {
        view.delegate = delegeteHandler;
        view.dataSource = delegeteHandler;
    }
    if (superView) {
        [superView addSubview:view];
    }
    if (constraint) {
        [view mas_makeConstraints:constraint];
    }
    if (configureHandler) {
        configureHandler(view);
    }
    return view;
}

@end
