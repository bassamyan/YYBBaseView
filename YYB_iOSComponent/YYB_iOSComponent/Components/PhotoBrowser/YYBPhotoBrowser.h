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

// 显示的图片数据源
@property (nonatomic,strong) NSMutableArray *images;
// 初始选中的图片下标
@property (nonatomic) NSInteger initialImageIndex;
// 获取图片视图对应的初始尺寸
@property (nonatomic,copy) CGRect (^ queryImageItemRectHandler)(NSInteger index);

// 是否允许删除照片
@property (nonatomic) BOOL isDeletionValid;
// 点击删除图标后的回调,用于确认是否删除图片
@property (nonatomic,copy) void (^ deleteImageQueryHandler)(NSInteger index);
// 确认删除后的回调
@property (nonatomic,copy) void (^ deleteImageActionHandler)(NSInteger index);
- (void)deleteImageAtIndex:(NSInteger)index;
@property (nonatomic,copy) void (^ reloadImagesHandler)(void);

@end

NS_ASSUME_NONNULL_END
