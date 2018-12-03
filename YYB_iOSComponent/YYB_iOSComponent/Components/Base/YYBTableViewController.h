//
//  YYBTableViewController.h
//  SavingPot365
//
//  Created by Aokura on 2018/7/4.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>

@interface YYBTableViewController : YYBViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic,strong) NSMutableArray *results;

@end
