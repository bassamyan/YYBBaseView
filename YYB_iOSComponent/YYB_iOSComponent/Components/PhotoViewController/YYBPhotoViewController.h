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

@property (nonatomic,copy) void (^ imageAssetQueryHandler)(PHAsset *asset);
@property (nonatomic,copy) void (^ imageAssetsQueryHandler)(NSArray *assets);

@property (nonatomic) BOOL isMultipleImagesRequired;
@property (nonatomic) NSInteger maxAllowedImages;
@property (nonatomic) BOOL isImageRequired; // 是否最后得到的是UIImage

@end
