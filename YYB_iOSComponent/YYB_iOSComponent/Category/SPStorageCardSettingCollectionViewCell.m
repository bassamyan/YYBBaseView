//
//  SPStorageCardSettingCollectionViewCell.m
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "SPStorageCardSettingCollectionViewCell.h"
#import "YYBShadowButton.h"

@interface SPStorageCardSettingCollectionViewCell ()
@property (nonatomic,strong) YYBShadowButton *shadowView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation SPStorageCardSettingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    _shadowView = [YYBShadowButton viewWithSuperView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20.0f, 10.0f, 20.0f, 0.0f));
    } configureHandler:^(YYBShadowButton *view) {
        view.actionButton.backgroundColor = [UIColor whiteColor];
        [view.actionButton cornerRadius:8.0f];
        [view.shadowView setLayerShadow:[UIColor colorWithHexInteger:0xEBEBEB alpha:0.6f] offset:CGSizeMake(0, 1.0f) radius:15.0f];
        [view.actionButton addTarget:self action:@selector(actionButtonHandler) forControlEvents:1<<6];
    }];
    
    _iconView = [UIImageView imageViewWithIcon:@"ic_storage_setting" superView:self.shadowView.actionButton constraint:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shadowView.actionButton.mas_centerY).offset(-2.5f);
        make.centerX.equalTo(self.shadowView.actionButton);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
    } configureImageViewHandler:^(UIImageView *iconView) {
        iconView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
    _titleLabel = [UILabel labelWithText:@"卡片管理" textColor:[UIColor colorWithHexInteger:0xD5D5D5] font:[UIFont systemFontOfSize:15.0f weight:UIFontWeightSemibold] superView:self.shadowView.actionButton constraint:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(5.0f);
        make.centerX.equalTo(self.iconView);
    } configureHandler:nil];
    
    return self;
}

- (void)actionButtonHandler {
    if (self.cardSettingActionHandler) {
        self.cardSettingActionHandler();
    }
}

@end
