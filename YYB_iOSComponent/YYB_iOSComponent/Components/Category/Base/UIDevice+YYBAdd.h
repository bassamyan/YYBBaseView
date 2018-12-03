//
//  UIDevice+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/3.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YYBAdd)

+ (BOOL)iPhoneXSeries;

// 顶部safearea
+ (CGFloat)safeAreaTop;

// 底部safearea
+ (CGFloat)safeAreaBottom;

@end

NS_ASSUME_NONNULL_END
