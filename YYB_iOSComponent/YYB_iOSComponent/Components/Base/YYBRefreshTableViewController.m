//
//  YYBRefreshTableViewController.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/27.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBRefreshTableViewController.h"

@interface YYBRefreshTableViewController ()

@end

@implementation YYBRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    if (self.isTableViewHeaderExist) {
        [self.tableView addRefreshHeaderWithClass:[YYBRefreshSpotTopView class] handler:^{
            @strongify(self);
            [self reloadContent];
        }];
    }
    
    if (self.isTableViewFooterExist) {
        [self.tableView addRefreshFooterWithClass:[YYBRefreshSpotBottomView class] handler:^{
            @strongify(self);
            [self beginRefreshAnimation];
        }];
    }
    
    [self reloadInitialContent];
}

- (BOOL)isTableViewFooterExist {
    return TRUE;
}

- (BOOL)isTableViewHeaderExist {
    return TRUE;
}

- (YYBAlertView *)firstQueryCoveredAlertView {
    return nil;
}

- (NSArray *)appendData:(id)responseObject {
    return nil;
}

- (void)refreshCompletePreActionHandler:(BOOL)isHeaderMethod {
    
}

- (void)refreshCompletedActionHandler:(BOOL)isHeaderMethod {
    
}

- (void)startRequestMethodsWithCompletionHandler:(void (^)(id _Nonnull, NSDictionary * _Nonnull))completionHandler errorHandler:(void (^)(NSError * _Nonnull, NSDictionary * _Nonnull))errorHandler isHeaderMethod:(BOOL)isHeaderMethod {
    
}

- (void)reloadInitialContent {
    @weakify(self);
    self.refreshAlertView = [self firstQueryCoveredAlertView];
    [self startRequestMethodsWithCompletionHandler:^(id responseObject, NSDictionary *params) {
        @strongify(self);
        [self refreshCompletePreActionHandler:TRUE];
        
        NSArray *results = [self appendData:responseObject];
        if (results.count > 0) {
            self.results = results.mutableCopy;
        } else {
            self.results = [NSMutableArray new];
        }
        
        [self.tableView reloadData];
        if (self.refreshAlertView) {
            [self.refreshAlertView closeAlertView];
        }
        
        [self refreshCompletedActionHandler:TRUE];
    } errorHandler:^(NSError * _Nonnull error, NSDictionary *params) {
        @strongify(self);
        if (self.refreshAlertView) {
            [self.refreshAlertView closeAlertView];
        }
        [YYBAlertView showAlertViewWithError:error];
    } isHeaderMethod:TRUE];
}

- (void)reloadContent {
    @weakify(self);
    [self startRequestMethodsWithCompletionHandler:^(id  _Nonnull responseObject, NSDictionary *params) {
        @strongify(self);
        [self refreshCompletePreActionHandler:TRUE];
        
        NSArray *results = [self appendData:responseObject];
        if (results.count > 0) {
            self.results = results.mutableCopy;
        } else {
            self.results = [NSMutableArray new];
        }
        
        [self.tableView reloadData];
        if (self.refreshAlertView) {
            [self.refreshAlertView closeAlertView];
        }
        [self.tableView.header endRefreshAnimation];
        
        [self refreshCompletedActionHandler:TRUE];
    } errorHandler:^(NSError * _Nonnull error, NSDictionary *params) {
        @strongify(self);
        [self.tableView.header endRefreshAnimation];
        [YYBAlertView showAlertViewWithError:error];
    } isHeaderMethod:TRUE];
}

- (void)beginRefreshAnimation {
    @weakify(self);
    [self startRequestMethodsWithCompletionHandler:^(id  _Nonnull responseObject, NSDictionary *params) {
        @strongify(self);
        [self refreshCompletePreActionHandler:FALSE];
        
        NSArray *results = [self appendData:responseObject];
        if (results.count > 0) {
            [self.results addObjectsFromArray:results];
        }
        
        [self.tableView.footer endRefreshAnimationWithEndHandler:^{
            if (results.count > 0) {
                [self.tableView reloadData];
            } else {
                [self.tableView removeFooterView];
                [self.tableView addRefreshDoneView];
            }

            [self refreshCompletedActionHandler:FALSE];
        }];
        
    } errorHandler:^(NSError * _Nonnull error, NSDictionary *params) {
        @strongify(self);
        [self.tableView.footer endRefreshAnimation];
        [YYBAlertView showAlertViewWithError:error];
    } isHeaderMethod:FALSE];
}

@end
