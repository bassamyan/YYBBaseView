//
//  UIViewController+YYBPhotoBrowser.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "UIViewController+YYBPhotoBrowser.h"
#import "YYBAlertView+YYBPhotoBrowser.h"

@implementation UIViewController (YYBPhotoBrowser)

- (nullable YYBPhotoBrowser *)showPhotoBrowserWithImages:(NSArray *)images queryImageRectHandler:(CGRect (^)(NSInteger))queryImageRectHandler initialImageIndex:(NSInteger)initialImageIndex isDeletable:(BOOL)isDeletable deletionCheckHandler:(nullable void (^)(NSInteger))deletionCheckHandler reloadImageSourceHandler:(nullable void (^)(NSInteger))reloadImageSourceHandler configureHandler:(nonnull void (^)(YYBPhotoBrowser * _Nonnull))configureHandler
{
    YYBPhotoBrowserTransition *transition = [[YYBPhotoBrowserTransition alloc] init];
    transition.imageURL = [images objectAtIndex:initialImageIndex];
    transition.fromImageRect = queryImageRectHandler(initialImageIndex);
    
    YYBPhotoBrowser *browser = [[YYBPhotoBrowser alloc] init];
    browser.images = [images mutableCopy];
    browser.transitioningDelegate = transition;
    browser.transition = transition;
    browser.isDeletable = isDeletable;
    browser.initialImageIndex = initialImageIndex;
    browser.queryImageItemRectHandler = queryImageRectHandler;
    
    @weakify(browser);
    browser.deleteImageCheckHandler = ^(NSInteger index) {
        if (deletionCheckHandler) {
            deletionCheckHandler(index);
        } else {
            [YYBAlertView showCheckPhotoDeletionAlertViewWithTitle:@"\n确定要删除这张图片吗?\n" detail:nil cancelActionTitle:@"取消" confirmActionTitle:@"确定" confirmActionHandler:^{
                @strongify(browser);
                [browser deleteImageAtIndex:index];
                if (reloadImageSourceHandler) {
                    reloadImageSourceHandler(index);
                }
            }];
        }
    };
    
    if (configureHandler) {
        configureHandler(browser);
    }
    
    [self presentViewController:browser animated:TRUE completion:nil];
    return browser;
}

- (void)showPhotoBrowserWithImage:(id)image configureHandler:(void (^)(YYBPhotoBrowser * _Nonnull))configureHandler
{
    [self showPhotoBrowserWithImages:@[image] queryImageRectHandler:^CGRect(NSInteger index) {
        return CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 0, 0);
    } initialImageIndex:0 isDeletable:FALSE deletionCheckHandler:nil reloadImageSourceHandler:nil configureHandler:configureHandler];
}

@end
