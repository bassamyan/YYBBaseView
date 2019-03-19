//
//  UIViewController+YYBPhotoViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "UIViewController+YYBPhotoViewController.h"

@implementation UIViewController (YYBPhotoViewController)

- (void)showPhotoViewControllerWithMaxSelectImageCount:(NSInteger)maxValue imagesSelectedHandler:(void (^)(NSArray * _Nonnull))imagesSelectedHandler configureHandler:(nullable void (^)(YYBPhotoViewController * _Nonnull))configureHandler
{
    YYBPhotoViewController *controller = [[YYBPhotoViewController alloc] init];
    
    controller.maxRequiredImages = maxValue;
    controller.isFormattedByUIImage = TRUE;
    controller.imageResultsQueryHandler = imagesSelectedHandler;
    
    if (configureHandler) {
        configureHandler(controller);
    }
    
    [self presentViewController:controller animated:TRUE completion:nil];
}

@end
