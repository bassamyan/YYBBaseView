//
//  UIViewController+YYBPhotoViewController.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBPhotoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYBPhotoViewController)

- (void)showPhotoViewControllerWithMaxSelectImageCount:(NSInteger)maxValue imagesSelectedHandler:(void (^)(NSArray *images))imagesSelectedHandler configureHandler:(nullable void (^)(YYBPhotoViewController *sender))configureHandler;

@end

NS_ASSUME_NONNULL_END
