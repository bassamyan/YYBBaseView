//
//  YYBNavigationBarContainer.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBNavigationBarContainer : UIControl

@property (nonatomic) UIEdgeInsets contentEdgeInsets;
@property (nonatomic) CGSize contentSize;

@property (nonatomic,copy) void (^ tapedActionHandler)(YYBNavigationBarContainer *view);

@end
