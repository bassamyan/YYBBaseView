//
//  YYBAlertView+Cover.h
//  AFNetworking
//
//  Created by Sniper on 2019/3/27.
//

#import "YYBAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (Cover)

+ (YYBAlertView *)showAlertLoadingViewWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor;
+ (YYBAlertView *)showAlertLoadingViewWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
