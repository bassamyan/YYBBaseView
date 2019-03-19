//
//  UIViewController+GesOverlay.h
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GesOverlay)

- (void)presentGesOverlayWithClassName:(NSString *)className configureHandler:(nullable void (^)(id controller))configureHandler;

@end

NS_ASSUME_NONNULL_END
