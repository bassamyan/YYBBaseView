//
//  YYBAlbumTableViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlbumTableViewCell.h"
#import "PHAsset+YYBPhotoViewController.h"
#import "YYBLayout.h"

@interface YYBAlbumTableViewCell ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation YYBAlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _iconView = [UIImageView imageViewWithIcon:nil superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    } configureImageViewHandler:^(UIImageView *iconView) {
        iconView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds = YES;
    }];
    
    _nameLabel = [UILabel labelWithText:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16.0f] superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10.0f);
        make.centerY.equalTo(self.iconView);
    } configureHandler:nil];
    
    return self;
}

- (void)setCollection:(PHAssetCollection *)collection {
    _collection = collection;
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:option];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ (%@)",collection.localizedTitle,@(result.count).stringValue];
    
    if (result.count > 0) {
        @weakify(self);
        PHAsset *asset = [result firstObject];
        [asset produceImageWithTargetSize:CGSizeMake(80.0f, 80.0f) completionHandler:^(UIImage *image, NSString *filename) {
            @strongify(self);
            self.iconView.image = image;
        }];
    } else {
        self.iconView.image = nil;
    }
}

@end
