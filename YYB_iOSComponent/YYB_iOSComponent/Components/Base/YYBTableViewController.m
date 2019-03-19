//
//  YYBTableViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBTableViewController.h"

@interface YYBTableViewController ()

@end

@implementation YYBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _results = [NSMutableArray new];
    
    _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = [self tableViewContentInsets];
    [self.view addSubview:_tableView];
}

- (UIEdgeInsets)tableViewContentInsets {
    return UIEdgeInsetsMake([self heightForNavigationBar], 0, [UIDevice safeAreaBottom], 0);
}

- (void)setResults:(NSMutableArray *)results {
    _results = results;
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

@end
