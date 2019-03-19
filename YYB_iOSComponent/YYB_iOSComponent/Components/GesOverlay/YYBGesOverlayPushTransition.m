//
//  YYBGesOverlayPushTransition.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBGesOverlayPushTransition.h"

@interface YYBGesOverlayPushTransition ()
@property (nonatomic,strong) UIView *contentView;

@end

@implementation YYBGesOverlayPushTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = transitionContext.containerView;
    
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [contentView addSubview:from.view];
    
    [contentView addSubview:_contentView];
    _contentView.frame = from.view.bounds;
    
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = to.view;
    
    [contentView addSubview:container];
    container.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(container.frame));
    
    self.contentView.alpha = 0.0f;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.contentView.alpha = 0.3f;
        container.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:TRUE];
    }];
}

@end
