//
//  YICreateImageCollectionViewCell.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface YICreateImageCollectionViewCell : UICollectionViewCell

- (void)configureIcon:(nullable UIImage *)icon imageURL:(nullable NSString *)imageURL;
- (void)renderItemWithAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
