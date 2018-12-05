//
//  YICreateImageCollectionViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YICreateImageCollectionViewCell.h"
#import "PHAsset+YYBPhotoViewController.h"

@interface YICreateImageCollectionViewCell ()
@property (nonatomic,strong) UIImageView *iconView;

@end

@implementation YICreateImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _iconView = [UIImageView imageViewWithIcon:nil superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    } configureImageViewHandler:^(UIImageView *iconView) {
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds = TRUE;
    }];
    
    return self;
}

- (void)configureIcon:(nullable UIImage *)icon imageURL:(nullable NSString *)imageURL {
    _iconView.image = nil;
    
    if (icon) {
        _iconView.image = icon;
    } else {
        NSString *utf8 = [imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:utf8] placeholderImage:[UIImage imageNamed:@"ic_icon_placeholder"]];
    }
}

- (void)renderItemWithAsset:(PHAsset *)asset {
    _iconView.image = nil;
    
    [asset produceImageWithTargetSize:CGSizeZero completionHandler:^(UIImage *image, NSString *filename) {
        self.iconView.image = image;
    }];
}

@end
