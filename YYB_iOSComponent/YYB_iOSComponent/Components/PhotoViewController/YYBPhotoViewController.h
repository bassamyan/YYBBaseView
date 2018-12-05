//
//  YYBPhotoViewController.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import <Photos/Photos.h>

@interface YYBPhotoViewController : YYBViewController

@property (nonatomic,copy) void (^ imageResultQueryHandler)(PHAsset *result);
@property (nonatomic,copy) void (^ imageResultsQueryHandler)(NSArray *results);

@property (nonatomic) NSInteger maxRequiredImages; // 最大可允许选择的图片数量
@property (nonatomic) BOOL isCheckImageEnable; // 是否可修改选择的图片,如果不可以则直接点击图片就结束, 默认为TRUE
@property (nonatomic) BOOL isUIImageRequired; // 是否最后得到的是UIImage, 否则输出的是PHAsset

@end
