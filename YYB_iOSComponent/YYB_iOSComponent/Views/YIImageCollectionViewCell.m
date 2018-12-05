//
//  YIImageCollectionViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/4.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YIImageCollectionViewCell.h"

@implementation YIImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _iconView = [UIImageView imageViewWithIcon:nil superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    } configureImageViewHandler:^(UIImageView *iconView) {
        iconView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
    return self;
}

@end
