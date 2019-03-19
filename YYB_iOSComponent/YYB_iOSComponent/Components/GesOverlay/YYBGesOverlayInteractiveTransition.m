//
//  YYBGesOverlayInteractiveTransition.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBGesOverlayInteractiveTransition.h"

@interface YYBGesOverlayInteractiveTransition ()
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIView *fromView;

@property (nonatomic,weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic,strong) UIViewController *detailViewController;

@end

@implementation YYBGesOverlayInteractiveTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (void)setPan:(UIPanGestureRecognizer *)pan {
    _pan = pan;
    [_pan addTarget:self action:@selector(recogizerDidUpdate:)];
}

- (CGFloat)scaleOfRecogzier {
    CGPoint translation = [_pan translationInView:_pan.view];
    CGFloat scale = 1 - (translation.y / [UIScreen mainScreen].bounds.size.height);
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    return scale;
}

- (void)recogizerDidUpdate:(UIPanGestureRecognizer *)recognizer {
    CGFloat percent = [self scaleOfRecogzier];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:percent];
            
            CGPoint translation = [_pan translationInView:_pan.view];
            [self updateTransition:translation];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (percent > 0.85f) {
                [self cancelInteractiveTransition];
                [self cancelTransition:percent];
            } else {
                [self finishInteractiveTransition];
                [self finishTransition:percent];
            }
        }
            break;
        default: {
            [self cancelInteractiveTransition];
            [self cancelTransition:percent];
        }
            break;
    }
}

- (void)updateTransition:(CGPoint)translation {
    if (translation.y > 0) {
        _fromView.transform = CGAffineTransformMakeTranslation(0, translation.y);
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    
    UIView *contentView = _transitionContext.containerView;
    
    UIViewController *to = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:to.view];
    
    _backgroundView.frame = to.view.bounds;
    _backgroundView.alpha = 0.3f;
    [contentView addSubview:_backgroundView];
    
    UIViewController *from = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [contentView addSubview:from.view];
    
    _fromView = from.view;
}

- (void)cancelTransition:(CGFloat)percent {
    [UIView animateWithDuration:0.2f animations:^{
        self.fromView.transform = CGAffineTransformIdentity;
    }];
    
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}

- (void)finishTransition:(CGFloat)percent {
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundView.alpha = 0.0f;
        self.fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.fromView.frame));
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}


@end
