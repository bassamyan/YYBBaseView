//
//  UIDevice+YYBAdd.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/3.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "UIDevice+YYBAdd.h"

@implementation UIDevice (YYBAdd)

+ (BOOL)iPhoneXSeries {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 11.0, *)) {
        if (window.safeAreaInsets.bottom > 0.0f) {
            return TRUE;
        }
    }
    return FALSE;
}

+ (CGFloat)statusBarHeight {
    if (@available(iOS 11.0, *)) {
        if ([self iPhoneXSeries]) {
            return [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
        }
    }
    return 20.0f;
}

+ (CGFloat)safeAreaTop {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.bottom > 0.0f) {
            return [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
        }
    }
    return 20.0f;
}

+ (CGFloat)safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.bottom > 0.0f) {
            return [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
        }
    }
    return 0.0f;
}

@end
