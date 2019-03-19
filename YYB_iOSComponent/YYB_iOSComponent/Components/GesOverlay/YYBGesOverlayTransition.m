//
//  YYBGesOverlayTransition.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBGesOverlayTransition.h"

@interface YYBGesOverlayTransition ()
@property (nonatomic,strong) YYBGesOverlayPopTransition *pop;
@property (nonatomic,strong) YYBGesOverlayPushTransition *push;
@property (nonatomic,strong) YYBGesOverlayInteractiveTransition *transition;

@end

@implementation YYBGesOverlayTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _push = [[YYBGesOverlayPushTransition alloc] init];
    _pop = [[YYBGesOverlayPopTransition alloc] init];
    _transition = [[YYBGesOverlayInteractiveTransition alloc] init];
    
    return self;
}

- (void)setPan:(UIPanGestureRecognizer *)pan {
    _pan = pan;
    _transition.pan = pan;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _push;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _pop;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (_pan) {
        return _transition;
    } else {
        return nil;
    }
}

@end
