//
//  YYBPhotoViewController.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/27.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
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
