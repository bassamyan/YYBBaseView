//
//  YYBPhotoBrowserPushAnimator.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoBrowserPushAnimator.h"

@interface YYBPhotoBrowserPushAnimator ()
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIImageView *iconView;

@end

@implementation YYBPhotoBrowserPushAnimator

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = transitionContext.containerView;
    
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    to.view.hidden = TRUE;
    [contentView addSubview:to.view];
    
    [contentView addSubview:_backgroundView];
    _backgroundView.frame = contentView.bounds;
    _backgroundView.alpha = 0.0f;
    
    [contentView addSubview:_iconView];
    
    if ([_imageResource isKindOfClass:[UIImage class]]) {
        _iconView.image = _imageResource;
    } else {
        NSString *utf8 = [_imageResource stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:utf8]];
    }
    _iconView.frame = _fromImageRect;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.backgroundView.alpha = 1.0f;
        self.iconView.frame = contentView.bounds;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.iconView removeFromSuperview];
        to.view.hidden = FALSE;
        
        [transitionContext completeTransition:TRUE];
    }];
}

@end
