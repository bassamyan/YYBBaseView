//
//  YYBPhotoBrowserTransition.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoBrowserTransition.h"

@interface YYBPhotoBrowserTransition ()
@property (nonatomic,strong) YYBPhotoBrowserPopAnimator *pop;
@property (nonatomic,strong) YYBPhotoBrowserPushAnimator *push;
@property (nonatomic,strong) YYBPhotoBrowserInteractiveTransition *transition;

@end

@implementation YYBPhotoBrowserTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _push = [[YYBPhotoBrowserPushAnimator alloc] init];
    _pop = [[YYBPhotoBrowserPopAnimator alloc] init];
    _transition = [[YYBPhotoBrowserInteractiveTransition alloc] init];
    
    return self;
}

- (void)setFromImageRect:(CGRect)fromImageRect {
    _push.fromImageRect = fromImageRect;
    _transition.fromImageRect = fromImageRect;
}

- (void)setImageURL:(id)imageURL {
    _push.imageURL = imageURL;
    _transition.imageURL = imageURL;
}

- (void)setFinishImageRect:(CGRect)finishImageRect {
    _transition.finishImageRect = finishImageRect;
}

- (void)setPan:(nullable UIPanGestureRecognizer *)pan {
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
