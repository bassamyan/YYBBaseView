//
//  YYBRefreshCollectionViewController.m
//  SavingPot365
//
//  Created by Sniper on 2019/2/15.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBRefreshCollectionViewController.h"

@interface YYBRefreshCollectionViewController ()

@end

@implementation YYBRefreshCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    if (self.isCollectionViewHeaderExist) {
        [self.collectionView addRefreshHeaderWithClass:[YYBRefreshSpotTopView class] handler:^{
            @strongify(self);
            [self reloadContent];
        }];
    }
    
    if (self.isCollectionViewFooterExist) {
        [self.collectionView addRefreshFooterWithClass:[YYBRefreshBottomView class] handler:^{
            @strongify(self);
            [self beginRefreshAnimation];
        }];
    }
    
    [self reloadInitialContent];
}

- (BOOL)isCollectionViewHeaderExist {
    return TRUE;
}

- (BOOL)isCollectionViewFooterExist {
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
        
        [self.collectionView reloadData];
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
        
        [self.collectionView reloadData];
        if (self.refreshAlertView) {
            [self.refreshAlertView closeAlertView];
        }
        
        [self.collectionView.header endRefreshAnimationWithEndHandler:^{
            [self refreshCompletedActionHandler:TRUE];
        }];
        
    } errorHandler:^(NSError * _Nonnull error, NSDictionary *params) {
        @strongify(self);
        [self.collectionView.header endRefreshAnimation];
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
        
        [self.collectionView.footer endRefreshAnimationWithEndHandler:^{
            if (results.count > 0) {
                [self.collectionView reloadData];
            }
            
            [self refreshCompletedActionHandler:FALSE];
        }];
        
    } errorHandler:^(NSError * _Nonnull error, NSDictionary *params) {
        @strongify(self);
        [self.collectionView.footer endRefreshAnimation];
        [YYBAlertView showAlertViewWithError:error];
    } isHeaderMethod:FALSE];
}

@end
