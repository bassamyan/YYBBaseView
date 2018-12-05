//
//  YYBPhotoBrowser.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/27.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import "YYBPhotoBrowserTransition.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowser : YYBViewController

@property (nonatomic,strong,readonly) UIView *contentView;
@property (nonatomic,strong) YYBPhotoBrowserTransition *transition;

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic) NSInteger initialImageIndex;
// 获取图片视图对应的初始尺寸
@property (nonatomic,copy) CGRect (^ queryImageItemRectHandler)(NSInteger index);

@property (nonatomic) BOOL isDeletable; // 是否允许删除照片

// 删除图片回调
@property (nonatomic,copy) void (^ deleteImageCheckHandler)(NSInteger index);
@property (nonatomic,copy) void (^ deleteImageHandler)(NSInteger index);
- (void)deleteImageAtIndex:(NSInteger)index;
@property (nonatomic,copy) void (^ reloadImagesHandler)(void);

@end

NS_ASSUME_NONNULL_END
