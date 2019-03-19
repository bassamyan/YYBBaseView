//
//  YYBGesOverlayTransition.h
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBGesOverlayPopTransition.h"
#import "YYBGesOverlayPushTransition.h"
#import "YYBGesOverlayInteractiveTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBGesOverlayTransition : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong,nullable) UIPanGestureRecognizer *pan;

@end

NS_ASSUME_NONNULL_END
