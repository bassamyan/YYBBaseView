//
//  YYBPhotoBrowser.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/27.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import "YYBPhotoBrowserTransition.h"
#import "UIImage+YYBAdd.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowser : YYBViewController

// 手势操作视图代理
@property (nonatomic,strong) YYBPhotoBrowserTransition *transition;

// 需要展示的图片
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic) NSInteger initialIndex;

// 是否允许删除照片
@property (nonatomic) BOOL isDeleteEnable;

// 删除图片事件
// 如果没有该回调则会响应reload事件
@property (nonatomic,copy) void (^ deleteImageHandler)(NSInteger index);
- (void)deleteImageAtIndex:(NSInteger)index;

// 刷新图片
@property (nonatomic,copy) void (^ reloadImagesHandler)(void);

// 获取图片视图对应的初始尺寸
@property (nonatomic,copy) CGRect (^ queryImageItemRectHandler)(NSInteger index);

// 相应删除按钮事件
@property (nonatomic,copy) void (^ deleteImageCheckHandler)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
