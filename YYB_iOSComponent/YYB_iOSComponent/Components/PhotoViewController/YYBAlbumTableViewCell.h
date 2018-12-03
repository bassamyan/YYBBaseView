//
//  YYBAlbumTableViewCell.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/27.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Masonry/Masonry.h>
#import "PHAsset+YYBPhoto.h"
#import "YYBLayout.h"

@interface YYBAlbumTableViewCell : UITableViewCell

@property (nonatomic,strong) PHAssetCollection *collection;

@end
