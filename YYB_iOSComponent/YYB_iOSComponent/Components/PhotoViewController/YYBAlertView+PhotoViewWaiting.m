//
//  YYBAlertView+Waiting.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/26.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlertView+PhotoViewWaiting.h"

@implementation YYBAlertView (PhotoViewWaiting)

+ (YYBAlertView *)showPhotoViewWaitingAlertView;
{
    return [self showPhotoViewWaitingAlertViewWithTimeInterval:1.0f];
}

+ (YYBAlertView *)showPhotoViewWaitingAlertViewWithTimeInterval:(NSTimeInterval)timeInterval
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenter;
    alertView.autoHideTimeInterval = timeInterval;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.contentView.backgroundColor = [UIColor blackColor];
        container.contentView.layer.cornerRadius = 8.0f;
        container.contentView.layer.shadowColor = [UIColor colorWithHexInteger:0xAFADAD alpha:0.5f].CGColor;
        container.contentView.layer.shadowOffset = CGSizeZero;
        container.contentView.layer.shadowRadius = 14.0f;
        container.contentView.layer.shadowOpacity = 1;
        container.contentView.layer.shouldRasterize = YES;
        container.contentView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        container.clipsToBounds = TRUE;
        
        [container addActivityIndicatorWithHandler:^(YYBAlertViewAction *action, UIActivityIndicatorView *view) {
            action.size = CGSizeMake(80.0f, 80.0f);
            [view startAnimating];
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
    return alertView;
}

@end
