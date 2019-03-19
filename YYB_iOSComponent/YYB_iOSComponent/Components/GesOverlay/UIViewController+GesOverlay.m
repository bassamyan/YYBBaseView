//
//  UIViewController+GesOverlay.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "UIViewController+GesOverlay.h"
#import "YYBGesOverlayTableViewController.h"

@implementation UIViewController (GesOverlay)

- (void)presentGesOverlayWithClassName:(NSString *)className configureHandler:(nullable void (^)(id _Nonnull))configureHandler {
    YYBGesOverlayTableViewController *vc = [[NSClassFromString(className) alloc] init];
    if (configureHandler) {
        configureHandler(vc);
    }
    
    YYBGesOverlayTransition *trans = [[YYBGesOverlayTransition alloc] init];
    vc.transition = trans;
//    vc.transitioningDelegate = trans;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.transitioningDelegate = trans;
    
    [self presentViewController:nav animated:TRUE completion:nil];
}

@end
