//
//  YYBShadowButton.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/10.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBShadowButton.h"

@interface YYBShadowButton ()

@end

@implementation YYBShadowButton

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _shadowView = [[UIView alloc] init];
    [self addSubview:_shadowView];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _actionButton = [UIButton buttonWithSuperView:_shadowView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    } configureButtonHandler:^(UIButton *button) {
        
    }];
    
    @weakify(self);
    [[_actionButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         if (self.buttonTapedHandler) {
             self.buttonTapedHandler();
         }
     }];
    
    return self;
}

@end
