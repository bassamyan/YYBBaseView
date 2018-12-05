//
//  YYBAlertView+YYBPhotoBrowser.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (YYBPhotoBrowser)

+ (void)showCheckPhotoDeletionAlertViewWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail cancelActionTitle:(nullable NSString *)cancelActionTitle confirmActionTitle:(nullable NSString *)confirmActionTitle confirmActionHandler:(YYBAlertViewActionBlankHandler)confirmActionHandler;

@end

NS_ASSUME_NONNULL_END
