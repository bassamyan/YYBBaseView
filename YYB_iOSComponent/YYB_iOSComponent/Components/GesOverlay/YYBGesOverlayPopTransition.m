//
//  YYBGesOverlayPopTransition.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBGesOverlayPopTransition.h"

@interface YYBGesOverlayPopTransition ()
@property (nonatomic,strong) UIView *contentView;

@end

@implementation YYBGesOverlayPopTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = transitionContext.containerView;
    
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:to.view];
    
    [contentView addSubview:_contentView];
    _contentView.frame = to.view.bounds;
    _contentView.alpha = 0.3f;
    
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [contentView addSubview:from.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.contentView.alpha = 0.0f;
        from.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(from.view.frame));
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:TRUE];
    }];
}

@end
