//
//  YYBPhotoBrowserInteractiveTransition.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoBrowserInteractiveTransition.h"
#import "UIImageView+YYBPhotoBrowser.h"
#import "YYBPhotoBrowser.h"

@interface YYBPhotoBrowserInteractiveTransition ()
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic,strong) UIViewController *detailViewController;

@end

@implementation YYBPhotoBrowserInteractiveTransition

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.clipsToBounds = TRUE;
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    
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
    self.backgroundView.alpha = percent;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (percent > 0.95f) {
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

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    
    UIView *contentView = _transitionContext.containerView;
    
    UIViewController *to = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:to.view];
    
    [contentView addSubview:_backgroundView];
    
    YYBPhotoBrowser *from = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.2f animations:^{
        from.contentView.backgroundColor = [UIColor clearColor];
    }];
    
    [contentView addSubview:from.view];
}

- (void)cancelTransition:(CGFloat)percent {
    
}

- (void)finishTransition:(CGFloat)percent {
    UIView *contentView = _transitionContext.containerView;
    
    UIViewController *to = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [contentView addSubview:to.view];
    
    _backgroundView.alpha = percent;
    [contentView addSubview:_backgroundView];
    
    [_iconView renderImageWithContent:_imageURL webImageCompletionHandler:nil];
    _iconView.frame = _finishImageRect;
    [contentView addSubview:_iconView];
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundView.alpha = 0.0f;
        self.iconView.frame = self.fromImageRect;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.iconView removeFromSuperview];
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

@end
