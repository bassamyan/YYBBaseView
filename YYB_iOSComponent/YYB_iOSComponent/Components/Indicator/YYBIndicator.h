//
//  YYBIndicator.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/5/29.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBIndicator : UIView

@property (nonatomic,readwrite) UIColor *activeTintColor;
@property (nonatomic,readwrite) UIColor *deactiveTintColor;

@property (nonatomic,readwrite) float progress;

@end
