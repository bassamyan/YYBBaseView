//
//  YYBPhotoSectionView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoSectionView.h"
#import "YYBLayout.h"

@interface YYBPhotoSectionView ()
@property (nonatomic,strong) UIImageView *iconView;

@end

@implementation YYBPhotoSectionView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _contentLabel = [UILabel labelWithText:@"所有照片" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18.0f] superView:self constraint:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    } configureHandler:nil];
    
    _iconView = [UIImageView imageViewWithIcon:@"ic_yyb_direction_top" superView:self constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_right).offset(10.0f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(10.0, 6.5f));
    } configureImageViewHandler:nil];
    
    [self addTarget:self action:@selector(sectionSelectedHandler) forControlEvents:1<<6];
    
    return self;
}

- (void)sectionSelectedHandler {
    self.selected = !self.selected;
    if (self.selected == TRUE) {
        self.librarySelectedHandler(TRUE);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        self.iconView.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView commitAnimations];
    } else {
        self.librarySelectedHandler(FALSE);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        self.iconView.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
    }
}

@end
