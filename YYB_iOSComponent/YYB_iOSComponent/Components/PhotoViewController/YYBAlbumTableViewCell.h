//
//  YYBAlbumTableViewCell.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Masonry/Masonry.h>
#import "PHAsset+YYBPhotoViewController.h"
#import "YYBLayout.h"

@interface YYBAlbumTableViewCell : UITableViewCell

@property (nonatomic,strong) PHAssetCollection *collection;

@end
