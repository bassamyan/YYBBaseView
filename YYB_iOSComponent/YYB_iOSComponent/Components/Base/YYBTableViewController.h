//
//  YYBTableViewController.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>

@interface YYBTableViewController : YYBViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic,strong) NSMutableArray *results;

- (UIEdgeInsets)tableViewContentInsets;

@end
