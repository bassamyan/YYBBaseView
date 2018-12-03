//
//  YYBPhotoCollectionViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoCollectionViewCell.h"
#import "PHAsset+YYBPhoto.h"

@interface YYBPhotoCollectionViewCell ()
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIButton *checkButton;
@property (nonatomic,strong) UIView *shadeView;

@end

@implementation YYBPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _iconView = [UIImageView imageViewWithIcon:nil superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    } configureImageViewHandler:^(UIImageView *iconView) {
        iconView.backgroundColor = [UIColor colorWithHexInteger:0xF6F6F6];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds = TRUE;
    }];
    
    _shadeView = [UIView viewWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6f] superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    } configureHandler:^(UIView *view) {
        view.hidden = TRUE;
    }];
    
    __weak typeof(self) wself = self;
    _checkButton = [UIButton buttonWithSuperView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-3.0f);
        make.top.equalTo(self.contentView).offset(3.0f);
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
    } configureButtonHandler:^(UIButton *button) {
        [button setBackgroundImage:[UIImage imageNamed:@"ic_yyb_check_no"] forState:0];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_yyb_check_yes"] forState:UIControlStateSelected];
    } tapedHandler:^(UIButton *sender) {
        __strong typeof(self) sself = wself;
        if (sself.selectActionHandler) {
            sself.selectActionHandler();
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSelectionStatusAction) name:@"YYBPHOTOSELECTEDNOTIFICATION" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAppendEnableAction) name:@"YYBPHOTOSAPPENDNOTIFICATION" object:nil];
    
    return self;
}

- (void)checkSelectionStatusAction {
    if (self.checkSelectionHandler) {
        BOOL selected = self.checkSelectionHandler();
        _checkButton.selected = selected;
    }
}

- (void)checkAppendEnableAction {
    if (self.checkAppendEnableHandler) {
        BOOL enable = self.checkAppendEnableHandler();
        _shadeView.hidden = enable == TRUE;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.iconView.image = [UIImage new];
}

- (void)renderItemWithAsset:(PHAsset *)asset selectionStatus:(BOOL)selectionStatus isMultipleImagesRequired:(BOOL)isMultipleImagesRequired isAppendImageEnable:(BOOL)isAppendImageEnable {
    self.iconView.hidden = TRUE;
    CGFloat size = ([UIScreen mainScreen].bounds.size.width - 5.0f) / 4.0f;
    
    __weak typeof(self) wself = self;
    [asset produceImageWithTargetSize:CGSizeMake(size * 2, size * 2) completionHandler:^(UIImage *image, NSString *filename) {
        __strong typeof(self) sself = wself;
        sself.iconView.hidden = FALSE;
        sself.iconView.image = image;
    }];
    
    _checkButton.selected = selectionStatus;
    _shadeView.hidden = isAppendImageEnable == TRUE;
    _checkButton.hidden = isMultipleImagesRequired == FALSE;
}

@end
