//
//  YYBRefreshCollectionViewController.h
//  SavingPot365
//
//  Created by Sniper on 2019/2/15.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBCollectionViewController.h"
#import "YYBAlertView.h"
#import "YYBAlertView+Error.h"
#import "YYBRefreshSpotTopView.h"
#import "YYBRefreshSpotBottomView.h"
#import "YYBRefreshDoneView.h"
#import "YYBRefreshBottomView.h"
#import "UIScrollView+YYBRefreshFooter.h"
#import "UIScrollView+YYBRefreshHeader.h"
#import "UIScrollView+YYBRefreshDoneView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBRefreshCollectionViewController : YYBCollectionViewController

@property (nonatomic,strong) YYBAlertView *refreshAlertView;

@property (nonatomic) BOOL isCollectionViewHeaderExist, isCollectionViewFooterExist;
- (NSArray *)appendData:(id)responseObject;
- (YYBAlertView *)firstQueryCoveredAlertView;

// 请求结束后的回调
// 首先处理这个方法,然后再执行默认的方法
- (void)refreshCompletePreActionHandler:(BOOL)isHeaderMethod;
- (void)refreshCompletedActionHandler:(BOOL)isHeaderMethod;

- (void)startRequestMethodsWithCompletionHandler:(void (^)(id responseObject, NSDictionary *params))completionHandler
                                    errorHandler:(void (^)(NSError *error, NSDictionary *params))errorHandler isHeaderMethod:(BOOL)isHeaderMethod;

- (void)reloadInitialContent;

@end

NS_ASSUME_NONNULL_END
