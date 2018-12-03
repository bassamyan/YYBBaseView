//
//  YYBPhotoBrowserPopAnimator.m
//  SavingPot365
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBPhotoBrowserPopAnimator.h"

@interface YYBPhotoBrowserPopAnimator ()

@end

@implementation YYBPhotoBrowserPopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = transitionContext.containerView;
    
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:to.view];
    
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [contentView addSubview:from.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        from.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(from.view.frame), 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:TRUE];
    }];
}

@end
