//
//  YYBAlertView.m
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlertView.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

@interface YYBAlertView ()

@end

@implementation YYBAlertView
{
    NSTimer *_autoHideTimer;
    UITapGestureRecognizer *_taped;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _isConstraintedWithContainer = FALSE;
    _isAutoControlKeyboardNotification = TRUE;
    _isUsingKeyboardNotification = TRUE;
    _isCloseAlertViewWhenTapedBackgroundView = TRUE;
    
    _containers = [NSMutableArray new];
    
    _backgroundView = [UIImageView new];
    _backgroundView.userInteractionEnabled = TRUE;
    [self addSubview:_backgroundView];
    
    _contentView = [UIView new];
    [self addSubview:_contentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyBoardWillChangeFrameHandler:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_actionHandler:) name:@"YYBALERTVIEW_ACTION_NOTIFICATION" object:nil];
    
    _taped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapedOnAction)];
    [_contentView addGestureRecognizer:_taped];
    
    return self;
}

- (void)resignKeyboardResponder
{
    YYBAlertViewContainer *container = [_containers objectAtIndex:_visibleContainerIndex];
    UIView *firstResponder = [container keyboardResponder];
    if (firstResponder)
    {
        [firstResponder resignFirstResponder];
    }
}

- (void)removeContentTapedHandler
{
    [_contentView removeGestureRecognizer:_taped];
}

- (void)contentViewTapedOnAction
{
    YYBAlertViewContainer *container = [_containers objectAtIndex:_visibleContainerIndex];
    UIView *firstResponder = [container keyboardResponder];
    if (firstResponder)
    {
        [firstResponder resignFirstResponder];
    }
    else
    {
        if (self.isCloseAlertViewWhenTapedBackgroundView)
        {
            [self closeAlertView];
        }
    }
}

- (void)_actionHandler:(NSNotification *)noti
{
    if ([noti.userInfo.allKeys containsObject:@"hash"])
    {
        NSUInteger hash = [[noti.userInfo objectForKey:@"hash"] integerValue];
        for (YYBAlertViewContainer *container in _containers)
        {
            if (container.hash == hash)
            {
                [self _closeContainerAtIndex:[_containers indexOfObject:container]];
            }
        }
    }
}

- (void)_keyBoardWillChangeFrameHandler:(NSNotification *)noti
{
    if (_containers.count > _visibleContainerIndex)
    {
        YYBAlertViewContainer *container = [_containers objectAtIndex:_visibleContainerIndex];
        UIView *firstResponder = [container keyboardResponder];
        if (_isUsingKeyboardNotification)
        {
            CGRect keyboardRect = [[noti.userInfo objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
            CGFloat keyboardy = CGRectGetMinY(keyboardRect);
            
            if (keyboardRect.origin.y == [UIScreen mainScreen].bounds.size.height)
            {
                container.transform = CGAffineTransformIdentity;
                [firstResponder resignFirstResponder];
            }
            else
            {
                CGFloat offset = 0.0f;
                if (_isAutoControlKeyboardNotification == FALSE)
                {
                    if (self.offsetOfContainerToKeyboard)
                    {
                        offset = self.offsetOfContainerToKeyboard(_visibleContainerIndex);
                    }
                }
                
                // 计算container上的firstResponder相对于self的位置
                CGRect responderRect = [self rectForResponder:firstResponder responderRect:firstResponder.bounds superView:firstResponder.superview];
                // 在屏幕上的firstResponder最大高度
                CGFloat responderMaxy = CGRectGetMaxY(responderRect) - container.scrollView.contentOffset.y;
                
                if (responderMaxy > keyboardy)
                {
                    CGFloat y = keyboardy - CGRectGetHeight(responderRect);
                    CGFloat ty = y - (responderMaxy - CGRectGetHeight(responderRect)) + container.transform.ty;
                    container.transform = CGAffineTransformMakeTranslation(0, ty - offset);
                }
            }
        }
    }
}

- (CGRect)rectForResponder:(UIView *)responder responderRect:(CGRect)responderRect superView:(UIView *)superView
{
    if (superView)
    {
        CGRect rect_reponder = [superView convertRect:responder.frame fromView:superView];
        if (CGRectEqualToRect(responderRect, CGRectZero))
        {
            responderRect = rect_reponder;
        }
        else
        {
            responderRect = CGRectMake(CGRectGetMinX(rect_reponder) + CGRectGetMinX(responderRect),
                                       CGRectGetMinY(rect_reponder) + CGRectGetMinY(responderRect),
                                       responderRect.size.width, responderRect.size.height);
        }
        
        UIView *super_superView = superView.superview;
        if (super_superView != self.contentView.superview)
        {
            CGRect rect = [self rectForResponder:superView responderRect:responderRect superView:super_superView];
            return rect;
        }
        else
        {
            return responderRect;
        }
    }
    else
    {
        return responderRect;
    }
}

- (void)_layoutAlertViewContainers
{
    _contentView.frame = self.bounds;
    _backgroundView.frame = self.bounds;
    
    if (_containers.count == 1 && _isConstraintedWithContainer)
    {
        YYBAlertViewContainer *container = [_containers objectAtIndex:0];
        container.frame = _contentView.bounds;
        [_contentView addSubview:container];
        
        CGSize containerSize = container.contentSizeWithActions;
        CGRect contentRect = CGRectMake((CGRectGetMinX(self.frame) + (CGRectGetWidth(self.frame) - containerSize.width) / 2),
                                        (CGRectGetMinY(self.frame) + (CGRectGetHeight(self.frame) - containerSize.height) / 2),
                                        containerSize.width, containerSize.height);
        self.frame = contentRect;
        _contentView.frame = self.bounds;
        _backgroundView.frame = self.bounds;
        container.frame = self.bounds;
        
        [container createActionViews];
    }
    else
    {
        if (_containers.count > 0)
        {
            for (NSInteger idx = 0; idx < _containers.count; idx ++)
            {
                YYBAlertViewContainer *container = [_containers objectAtIndex:idx];
                CGRect rect = CGRectZero;
                if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:containerRectsWithIndex:container:)])
                {
                    rect = [self.delegate alertView:self containerRectsWithIndex:idx container:container];
                }
                else if (self.createRectHandler)
                {
                    rect = self.createRectHandler(idx,container);
                }
                
                if (CGRectEqualToRect(CGRectZero, rect))
                {
                    if (idx > 0)
                    {
                        rect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                    }
                    else
                    {
                        rect = self.bounds;
                    }
                }
                
                if (container)
                {
                    container.frame = rect;
                    [_contentView addSubview:container];
                    [container createActionViews];
                }
            }
        }
    }
}

- (void)showAlertViewOnKeyboardWindow
{
    UIView *showView = nil;
    for (UIView *window in [UIApplication sharedApplication].windows)
    {
        if( [window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] )
        {
            showView = window;
            break;
        }
    }
    
    if (showView == nil)
    {
        showView = [UIApplication sharedApplication].keyWindow;
    }
    
    [showView addSubview:self];
    self.frame = showView.bounds;
    [self showAlertView];
}

- (void)showAlertViewOnKeyWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows)
    {
        if (window.windowLevel == UIWindowLevelNormal && window.isKeyWindow)
        {
            [window addSubview:self];
            self.frame = window.bounds;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertView];
            });
            break;
        }
    }
}

- (void)showAlertView
{
    switch (_displayAnimationStyle) {
        case YYBAlertViewAnimationStyleNone: {
            
        }
            break;
        case YYBAlertViewAnimationStyleCenter: {
            self.showContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container) {
                container.alpha = 0.0f;
                [UIView animateWithDuration:0.2f animations:^{
                    container.alpha = 1.0f;
                }];
                
                return TRUE;
            };
            
            self.closeContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container, void (^removeSubviewsHandler)(void)) {
                [UIView animateWithDuration:0.2f animations:^{
                    container.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    removeSubviewsHandler();
                }];
                
                return TRUE;
            };
        }
            break;
        case YYBAlertViewAnimationStyleBottom: {
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            
            self.createRectHandler = ^CGRect(NSInteger index, YYBAlertViewContainer *container) {
                CGSize contentSize = container.contentSizeWithActions;
                return CGRectMake((width - contentSize.width) / 2, height - contentSize.height, contentSize.width, contentSize.height);
            };
            
            __weak typeof(self) wself = self;
            self.showContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container) {
                container.transform = CGAffineTransformMakeTranslation(0, container.contentSizeWithActions.height);
                wself.backgroundView.alpha = 0.0f;
                
                [UIView animateWithDuration:0.2f animations:^{
                    container.transform = CGAffineTransformIdentity;
                    wself.backgroundView.alpha = 1.0f;
                }];
                
                return TRUE;
            };
            
            self.closeContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container, void (^removeSubviewsHandler)(void)) {
                wself.backgroundView.alpha = 1.0f;
                [UIView animateWithDuration:0.2f animations:^{
                    container.transform = CGAffineTransformMakeTranslation(0, container.contentSizeWithActions.height);
                    wself.backgroundView.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    removeSubviewsHandler();
                }];
                
                return TRUE;
            };
            
        }
            break;
        case YYBAlertViewAnimationStyleCenterShrink: {
            __weak typeof(self) wself = self;
            self.showContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container) {
                container.alpha = 0.0f;
                container.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                wself.backgroundView.alpha = 0.0f;
                [UIView animateWithDuration:0.2f animations:^{
                    container.alpha = 1.0f;
                    container.transform = CGAffineTransformIdentity;
                    wself.backgroundView.alpha = 1.0f;
                }];
                
                return TRUE;
            };
            
            self.closeContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container, void (^removeSubviewsHandler)(void)) {
                [UIView animateWithDuration:0.2f animations:^{
                    container.alpha = 0.0f;
                    container.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                    wself.backgroundView.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    removeSubviewsHandler();
                }];
                
                return TRUE;
            };
        }
            break;
        default:
            break;
    }
    
    [self _layoutAlertViewContainers];
    [self showContainerAtIndex:0];
    [self _setupAutoHideAction];
}

- (void)showContainerAtIndex:(NSInteger)index;
{
    if (_containers.count > index)
    {
        YYBAlertViewContainer *container = [_containers objectAtIndex:index];
        BOOL isAnimated = FALSE;
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:showContainerAtIndex:container:)])
        {
            isAnimated = [self.delegate alertView:self showContainerAtIndex:index container:container];
        }
        else if (self.showContainerHandler)
        {
            isAnimated = self.showContainerHandler(index,container);
        }
        
        // 默认的视图加载方式
        if (isAnimated == FALSE)
        {
            [UIView animateWithDuration:0.25f animations:^{
                if (index == 0)
                {
                    container.transform = CGAffineTransformIdentity;
                }
                else
                {
                    container.transform = CGAffineTransformMakeTranslation(0, - CGRectGetHeight(container.frame));
                }
            }];
        }
        
        _visibleContainerIndex = index;
    }
}

- (void)_closeContainerAtIndex:(NSInteger)index
{
    if (_containers.count > index)
    {
        YYBAlertViewContainer *container = [_containers objectAtIndex:index];
        BOOL isAnimated = FALSE;
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:closeContainerWithIndex:container:removeSubviewsHandler:)])
        {
            __weak typeof(self) weakself = self;
            isAnimated = [self.delegate alertView:self closeContainerWithIndex:index container:container removeSubviewsHandler:^{
                [weakself _removeContainerSubview];
            }];
        }
        else if (self.closeContainerHandler)
        {
            __weak typeof(self) weakself = self;
            isAnimated = self.closeContainerHandler(index,container,^{
                [weakself _removeContainerSubview];
            });
        }
        
        // 默认的视图移除方式
        if (isAnimated == FALSE)
        {
            [UIView animateWithDuration:0.25f animations:^{
                container.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self _removeContainerSubview];
            }];
        }
    }
}

- (void)_removeContainerSubview
{
    [_containers removeAllObjects];
    [self removeSubViews];
    [self removeFromSuperview];
}

- (void)closeContainerAtIndex:(NSInteger)index
{
    if (_containers.count > 1)
    {
        NSInteger idx = index;
        if (idx > 1)
        {
            idx --;
        }
        else
        {
            idx = 0;
        }
        
        [self _closeContainerAtIndex:index];
        [self showContainerAtIndex:idx];
    }
    else
    {
        [self closeAlertView];
    }
}

- (void)addContainerViewWithHandler:(void (^)(YYBAlertViewContainer *))handler
{
    if (handler)
    {
        YYBAlertViewContainer *container = [[YYBAlertViewContainer alloc] initWithFlexDirection:YYBAlertViewFlexDirectionVertical];
        handler(container);
        
        [_containers addObject:container];
    }
}

- (void)_setupAutoHideAction
{
    if (_autoHideTimeInterval == 0 || _autoHideTimeInterval == MAXFLOAT)
    {
        return;
    }
    _autoHideTimer = [NSTimer scheduledTimerWithTimeInterval:_autoHideTimeInterval
                                                      target:self
                                                    selector:@selector(autoHideTimerAction)
                                                    userInfo:nil
                                                     repeats:NO];
}

- (void)autoHideTimerAction
{
    [self _closeContainerAtIndex:_visibleContainerIndex];
}

- (void)closeAlertView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:closeAllContainersWithRemoveSubviewsHandler:)])
    {
        [self.delegate alertView:self closeAllContainersWithRemoveSubviewsHandler:^{
            [self _removeContainerSubview];
        }];
    }
    else if (self.closeAllContainersHandler)
    {
        __weak typeof(self) wself = self;
        self.closeAllContainersHandler(^{
            [wself _removeContainerSubview];
        });
    }
    else
    {
        [self _closeContainerAtIndex:_visibleContainerIndex];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
