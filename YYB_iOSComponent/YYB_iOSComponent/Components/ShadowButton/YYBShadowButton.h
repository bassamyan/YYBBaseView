//
//  YYBShadowButton.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/10.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIButton+YYBLayout.h"

@interface YYBShadowButton : UIView

@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIButton *actionButton;

@property (nonatomic,copy) void (^ buttonTapedHandler)(void);

@end
