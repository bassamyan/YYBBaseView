//
//  YYBPhotoCollectionViewCell.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Masonry/Masonry.h>

@interface YYBPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) PHAsset *asset;

- (void)renderItemWithAsset:(PHAsset *)asset selectionStatus:(BOOL)selectionStatus isMultipleImagesRequired:(BOOL)isMultipleImagesRequired isAppendImageEnable:(BOOL)isAppendImageEnable;

@property (nonatomic,copy) BOOL (^ checkSelectionHandler)(void);
@property (nonatomic,copy) BOOL (^ checkAppendEnableHandler)(void);

@property (nonatomic,copy) void (^ selectActionHandler)(void);

@end
