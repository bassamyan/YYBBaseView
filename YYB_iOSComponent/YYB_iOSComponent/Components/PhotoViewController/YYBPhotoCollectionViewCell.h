//
//  YYBPhotoCollectionViewCell.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/27.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Masonry/Masonry.h>
#import "YYBLayout.h"
#import "UIColor+YYBAdd.h"

@interface YYBPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) PHAsset *asset;

- (void)renderItemWithAsset:(PHAsset *)asset selectionStatus:(BOOL)selectionStatus isMultipleImagesRequired:(BOOL)isMultipleImagesRequired isAppendImageEnable:(BOOL)isAppendImageEnable;

@property (nonatomic,copy) BOOL (^ checkSelectionHandler)(void);
@property (nonatomic,copy) BOOL (^ checkAppendEnableHandler)(void);

@property (nonatomic,copy) void (^ selectActionHandler)(void);

@end
