//
//  YYBAlertView+Cover.m
//  AFNetworking
//
//  Created by Sniper on 2019/3/27.
//

#import "YYBAlertView+Cover.h"

@implementation YYBAlertView (Cover)

+ (YYBAlertView *)showAlertLoadingViewWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor
{
    return [self showAlertLoadingViewWithView:view backgroundColor:backgroundColor tintColor:[UIColor grayColor]];
}

+ (YYBAlertView *)showAlertLoadingViewWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor tintColor:(UIColor *)tintColor
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = backgroundColor;
    alertView.isCloseAlertViewWhenTapedBackgroundView = FALSE;
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenter;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        [container addActivityIndicatorWithHandler:^(YYBAlertViewAction *action, UIActivityIndicatorView *view) {
            action.size = CGSizeMake(80.0f, 80.0f);
            
            view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            view.tintColor = tintColor;
            [view startAnimating];
        }];
    }];
    
    [view addSubview:alertView];
    alertView.frame = view.bounds;
    [alertView showAlertView];
    
    return alertView;
}

@end
