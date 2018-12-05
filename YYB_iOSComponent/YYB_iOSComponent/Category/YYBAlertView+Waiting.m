//
//  YYBAlertView+Waiting.m
//  SavingPot365
//
//  Created by Aokura on 2018/9/26.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBAlertView+Waiting.h"

@implementation YYBAlertView (Waiting)

+ (YYBAlertView *)showWaitingAlertView;
{
    return [self showWaitingAlertViewWithTimeInterval:1.0f];
}

+ (YYBAlertView *)showWaitingAlertViewWithTimeInterval:(NSTimeInterval)timeInterval
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenter;
    alertView.autoHideTimeInterval = timeInterval;
//    alertView.isConstraintedWithContainer = TRUE;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        [container.shadowView setLayerShadow:[UIColor colorWithHexInteger:0xAFADAD alpha:0.5f] offset:CGSizeZero radius:14.0f];
        container.contentView.backgroundColor = [UIColor blackColor];
        [container.contentView cornerRadius:8.0f];
        
        [container addActivityIndicatorWithHandler:^(YYBAlertViewAction *action, UIActivityIndicatorView *view) {
            action.size = CGSizeMake(80.0f, 80.0f);
            [view startAnimating];
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
    return alertView;
}

@end
