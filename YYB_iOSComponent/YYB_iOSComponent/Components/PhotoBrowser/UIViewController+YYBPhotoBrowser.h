//
//  UIViewController+YYBPhotoBrowser.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBPhotoBrowser.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYBPhotoBrowser)

- (YYBPhotoBrowser *)showPhotoBrowserWithImage:(id)image imageRect:(CGRect)imageRect;

/**
 @param images 图片数据源,可以是URL或者UIImage
 @param queryImageRectHandler 获取图片控件的尺寸
 @param initialImageIndex 初始图片索引
 @param reloadImageSourceHandler 删除图片后刷新回调
 */
- (nullable YYBPhotoBrowser *)showPhotoBrowserWithImages:(NSArray *)images queryImageRectHandler:(CGRect(^)(NSInteger index))queryImageRectHandler initialImageIndex:(NSInteger)initialImageIndex isDeletable:(BOOL)isDeletable deleteActionHandler:(nullable void(^)(NSInteger index))deleteActionHandler reloadImageSourceHandler:(nullable void(^)(NSInteger index))reloadImageSourceHandler configureHandler:(nullable void(^)(YYBPhotoBrowser *browser))configureHandler;

/**
 @param image 图片数据源,可以是URL或者UIImage
 */
- (void)showPhotoBrowserWithImage:(id)image configureHandler:(nullable void(^)(YYBPhotoBrowser *browser))configureHandler;

@end

NS_ASSUME_NONNULL_END
