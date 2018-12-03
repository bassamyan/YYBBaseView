//
//  YYBTableViewController.m
//  SavingPot365
//
//  Created by Aokura on 2018/7/4.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBTableViewController.h"

@interface YYBTableViewController ()

@end

@implementation YYBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _tableView.contentInset = UIEdgeInsetsMake([self heightForNavigationBar], 0, [UIDevice safeAreaBottom], 0);
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