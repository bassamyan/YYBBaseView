//
//  UIViewController+YYBPhotoBrowser.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "UIViewController+YYBPhotoBrowser.h"

@implementation UIViewController (YYBPhotoBrowser)

- (YYBPhotoBrowser *)showPhotoBrowserWithImage:(id)image imageRect:(CGRect)imageRect
{
    return [self showPhotoBrowserWithImages:@[image] queryImageRectHandler:^CGRect(NSInteger index) {
        return imageRect;
    } initialImageIndex:0 isDeletable:FALSE deleteActionHandler:nil reloadImageSourceHandler:nil configureHandler:nil];
}

- (nullable YYBPhotoBrowser *)showPhotoBrowserWithImages:(NSArray *)images queryImageRectHandler:(CGRect (^)(NSInteger))queryImageRectHandler initialImageIndex:(NSInteger)initialImageIndex isDeletable:(BOOL)isDeletable deleteActionHandler:(nullable void (^)(NSInteger))deleteActionHandler reloadImageSourceHandler:(nullable void (^)(NSInteger))reloadImageSourceHandler configureHandler:(nullable void (^)(YYBPhotoBrowser * ))configureHandler
{
    YYBPhotoBrowserTransition *transition = [[YYBPhotoBrowserTransition alloc] init];
    transition.imageURL = [images objectAtIndex:initialImageIndex];
    transition.fromImageRect = queryImageRectHandler(initialImageIndex);
    
    YYBPhotoBrowser *browser = [[YYBPhotoBrowser alloc] init];
    browser.images = [images mutableCopy];
    browser.transitioningDelegate = transition;
    browser.transition = transition;
    browser.isDeletionValid = isDeletable;
    browser.initialImageIndex = initialImageIndex;
    browser.queryImageItemRectHandler = queryImageRectHandler;
    
    @weakify(browser);
    browser.deleteImageQueryHandler = ^(NSInteger index) {
        if (deleteActionHandler) {
            deleteActionHandler(index);
        } else {
            [YYBAlertView showAlertViewWithTitle:@"\n确定要删除这张图片吗?\n" detail:nil cancelActionTitle:@"取消" confirmActionTitle:@"确定" confirmActionHandler:^{
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

- (void)showPhotoBrowserWithImage:(id)image configureHandler:(nullable void (^)(YYBPhotoBrowser *))configureHandler
{
    [self showPhotoBrowserWithImages:@[image] queryImageRectHandler:^CGRect(NSInteger index) {
        return CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 0, 0);
    } initialImageIndex:0 isDeletable:FALSE deleteActionHandler:nil reloadImageSourceHandler:nil configureHandler:configureHandler];
}

@end
