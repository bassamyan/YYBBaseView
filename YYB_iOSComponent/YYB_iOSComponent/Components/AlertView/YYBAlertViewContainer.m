//
//  YYBAlertViewContainer.m
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlertViewContainer.h"
#import "UIView+Responder.h"

@implementation YYBAlertViewContainer {
    NSMutableArray *_innerViews;
    NSMutableArray *_innerActions;
    CGFloat _stretchTotalUsableSize;
    UITapGestureRecognizer *_taped;
}

- (instancetype)init
{
    return [self initWithFlexDirection:YYBAlertViewFlexDirectionVertical isUsingActionsContainer:TRUE];
}

- (YYBAlertViewContainer *)initWithFlexDirection:(YYBAlertViewFlexDirection)direction
{
    return [self initWithFlexDirection:direction isUsingActionsContainer:TRUE];
}

- (YYBAlertViewContainer *)initWithFlexDirection:(YYBAlertViewFlexDirection)direction isUsingActionsContainer:(BOOL)isUsingActionsContainer
{
    self = [super init];
    if (!self) return nil;
    
    _flexDirection = direction;
    
    _minimalWidth = 0;
    _maximalWidth = 300.0f;
    _minimalHeight = 0;
    _maximalHeight = 300.0f;
    
    _innerViews = [NSMutableArray new];
    _innerActions = [NSMutableArray new];
    
    _shadowView = [[UIView alloc] init];
    [self addSubview:_shadowView];
    
    _contentView = [[UIImageView alloc] init];
    _contentView.userInteractionEnabled = TRUE;
    [_shadowView addSubview:_contentView];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    [_contentView addSubview:_scrollView];
    
    if (isUsingActionsContainer)
    {
        _actionsContainer = [[YYBAlertViewContainer alloc] initWithFlexDirection:YYBAlertViewFlexDirectionVertical isUsingActionsContainer:FALSE];
        _actionsContainer.clipsToBounds = TRUE;
        [_contentView addSubview:_actionsContainer];
        [_actionsContainer removeContainerContentTapedHandler];
    }
    
    _taped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapedOnAction)];
    [_contentView addGestureRecognizer:_taped];
    
    return self;
}

- (void)removeContainerContentTapedHandler
{
    [_contentView removeGestureRecognizer:_taped];
}

- (void)contentViewTapedOnAction
{
    UIView *responder = [self keyboardResponder];
    if (responder)
    {
        [responder resignFirstResponder];
    }
}

- (UIView *)keyboardResponder
{
    return [self.scrollView searchKeyboardResponder];
}

- (void)setMaximalWidth:(CGFloat)maximalWidth
{
    _maximalWidth = maximalWidth;
    if (_actionsContainer)
    {
        _actionsContainer.maximalWidth = maximalWidth;
    }
}

- (void)setMaximalHeight:(CGFloat)maximalHeight
{
    _maximalHeight = maximalHeight;
    if (_actionsContainer)
    {
        _actionsContainer.maximalHeight = maximalHeight;
    }
}

- (void)setMinimalWidth:(CGFloat)minimalWidth
{
    _minimalWidth = minimalWidth;
    if (_actionsContainer)
    {
        _actionsContainer.minimalWidth = minimalWidth;
    }
}

- (void)setMinimalHeight:(CGFloat)minimalHeight
{
    _minimalHeight = minimalHeight;
    if (_actionsContainer)
    {
        _actionsContainer.minimalHeight = minimalHeight;
    }
}

- (CGSize)contentSize
{
    if (CGSizeEqualToSize(CGSizeZero, _contentSize))
    {
        [self createContentViewsWithCalculationStatus:TRUE];
    }
    return _contentSize;
}

- (CGSize)contentSizeWithActions
{
    if (CGSizeEqualToSize(CGSizeZero, _contentSizeWithActions))
    {
        CGSize contentSize = _actionsContainer.contentSize;
        if (_innerActions.count > 0)
        {
            CGFloat width_action = 0.0f, height_action = 0.0f;
            if (_flexDirection == YYBAlertViewFlexDirectionVertical)
            {
                width_action = MAX(self.contentSize.width, contentSize.width);
                height_action = self.contentSize.height + contentSize.height;
            }
            else if (_flexDirection == YYBAlertViewFlexDirectionHorizonal)
            {
                width_action = self.contentSize.width + contentSize.width;
                height_action = MAX(self.contentSize.height, contentSize.height);
            }
            
            _contentSizeWithActions = CGSizeMake(width_action, height_action);
        }
        else
        {
            _contentSizeWithActions = self.contentSize;
        }
    }
    return _contentSizeWithActions;
}

- (void)createActionViews
{
    // 先计算一遍轮廓尺寸以确定子视图位置
    [self createContentViewsWithCalculationStatus:TRUE];
    [self createContentViewsWithCalculationStatus:FALSE];
}

- (void)createContentViewsWithCalculationStatus:(BOOL)isCalculateContentSize
{
    if (_maximalWidth < _minimalWidth)
    {
        _maximalWidth = _minimalWidth;
    }
    
    if (_minimalWidth > _maximalWidth)
    {
        _minimalWidth = _maximalWidth;
    }
    
    if (_maximalHeight < _minimalHeight)
    {
        _maximalHeight = _minimalHeight;
    }
    
    if (_minimalHeight > _maximalHeight)
    {
        _minimalHeight = _maximalHeight;
    }
    
    // 依次排列视图
    CGFloat height_max = 0, width_max = 0;
    if (isCalculateContentSize == TRUE)
    {
        _stretchTotalUsableSize = 0;
    }
    
    for (NSInteger idx = 0; idx < _innerViews.count; idx ++)
    {
        CGFloat x = 0,y = 0,width = 0,height = 0.0f;
        UIEdgeInsets padding = UIEdgeInsetsZero, margin = UIEdgeInsetsZero;
        UIView *view = nil;
        NSObject *innerViewObject = [_innerViews objectAtIndex:idx];
        
        if ([innerViewObject isKindOfClass:[YYBAlertViewContainer class]])
        {
            YYBAlertViewContainer *container = (YYBAlertViewContainer *)innerViewObject;
            view = container;
            
            padding = container.padding;
            margin = container.margin;

            CGSize container_contentSize = container.contentSize;
            height = (container_contentSize.height == _maximalHeight) ? container_contentSize.height - margin.top - margin.bottom : container_contentSize.height;
            width = (container_contentSize.width == _maximalWidth) ? container_contentSize.width - margin.left - margin.right : container_contentSize.width;
        }
        else
        {
            YYBAlertViewAction *action = (YYBAlertViewAction *)innerViewObject;
            view = [action actionView];
            
            padding = action.padding;
            margin = action.margin;
            
            CGSize size = [action actionSizeWithContainerMaxWidth:_maximalWidth maxHeight:_maximalHeight];
            height = (size.height == _maximalHeight) ? size.height - margin.top - margin.bottom : size.height;
            width = (size.width == _maximalWidth) ? size.width - margin.left - margin.right : size.width;
            
            if (action.label)
            {
                if (width == 0)
                {
                    width = _maximalWidth - margin.left - margin.right;
                }
                
                if (_flexDirection == YYBAlertViewFlexDirectionVertical)
                {
                    CGSize label_size = [action labelSizeWithMaxWidth:width];
                    width = MIN(label_size.width, _maximalWidth);
                    height = label_size.height;
                }
                else if (_flexDirection == YYBAlertViewFlexDirectionHorizonal)
                {
                    CGSize label_size = [action labelSizeWithMaxWidth:action.size.width];
                    width = label_size.width;
                    height = MIN(label_size.height, _maximalHeight);
                }
            }
        }
        
        if (_flexDirection == YYBAlertViewFlexDirectionVertical)
        {
            y = height_max + padding.top + margin.top;
            if (_flexPosition == YYBAlertViewFlexPositionCenter)
            {
                x = (_contentSize.width - margin.left - margin.right - width) / 2 + padding.left - padding.right + margin.left;
            }
            else if (_flexPosition == YYBAlertViewFlexPositionEnd)
            {
                x = _contentSize.width - margin.left - margin.right - width - padding.right + padding.left - margin.right;
            }
            else if (_flexPosition == YYBAlertViewFlexPositionStart)
            {
                x = padding.left - margin.left - margin.right + margin.left;
            }
            else if (_flexPosition == YYBAlertViewFlexPositionStretch)
            {
                x = (_contentSize.width - width) / 2;
            }
            
            if (isCalculateContentSize == TRUE)
            {
                _stretchTotalUsableSize += height;
            }
            
            // 压缩尺寸
            if (_flexPosition == YYBAlertViewFlexPositionStretch && isCalculateContentSize == FALSE)
            {
                height = height / _stretchTotalUsableSize * (CGRectGetHeight(self.frame) - (_innerViews.count - 1) * _stretchValue);
            }
            
            width_max = MAX(width_max, width + margin.left + margin.right);
            height_max += height + padding.bottom + padding.top + margin.top + margin.bottom;
            
            if (_flexPosition == YYBAlertViewFlexPositionStretch && isCalculateContentSize == FALSE && idx != _innerViews.count - 1)
            {
                height_max += _stretchValue;
            }
        }
        else
        {
            x = width_max + padding.left + margin.left;
            if (_flexPosition == YYBAlertViewFlexPositionCenter)
            {
                y = (_contentSize.height - height - margin.bottom - margin.top) / 2 + padding.top - padding.bottom + margin.top;
            }
            else if (_flexPosition == YYBAlertViewFlexPositionEnd)
            {
                y = _contentSize.height - margin.bottom - margin.top - height - padding.bottom + padding.top - margin.bottom;
            }
            else if (_flexPosition == YYBAlertViewFlexPositionStart)
            {
                y = padding.top - margin.bottom - margin.top + margin.top;
            }

            if (isCalculateContentSize == TRUE)
            {
                _stretchTotalUsableSize += width;
            }
            
            if (_flexPosition == YYBAlertViewFlexPositionStretch && isCalculateContentSize == FALSE)
            {
                width = width / _stretchTotalUsableSize * (CGRectGetWidth(self.frame) - (_innerViews.count - 1) * _stretchValue);
            }
            
            height_max = MAX(height_max, height + margin.top + margin.bottom);
            width_max += width + padding.right + padding.left + margin.left + margin.right;
            
            if (_flexPosition == YYBAlertViewFlexPositionStretch && isCalculateContentSize == FALSE && idx != _innerViews.count - 1)
            {
                width_max += _stretchValue;
            }
        }
        
        if (isCalculateContentSize == FALSE)
        {
            view.frame = CGRectMake(x, y, width, height);
            [_scrollView addSubview:view];
            
            if ([innerViewObject isKindOfClass:[YYBAlertViewContainer class]])
            {
                YYBAlertViewContainer *container = (YYBAlertViewContainer *)innerViewObject;
                [container createContentViewsWithCalculationStatus:FALSE];
            }
        }
    }
    
    if (isCalculateContentSize == FALSE)
    {
        _scrollView.scrollEnabled = FALSE;
        if (_flexDirection == YYBAlertViewFlexDirectionVertical)
        {
            if (_maximalHeight < height_max)
            {
                _scrollView.scrollEnabled = TRUE;
            }
        }
        else if (_flexDirection == YYBAlertViewFlexDirectionHorizonal)
        {
            if (_maximalWidth < width_max)
            {
                _scrollView.scrollEnabled = TRUE;
            }
        }
        
        _scrollView.contentSize = CGSizeMake(width_max, height_max);
        
        width_max = MAX(_minimalWidth, MIN(width_max, _maximalWidth));
        height_max = MAX(_minimalHeight, MIN(height_max, _maximalHeight));
        
        _scrollView.frame = CGRectMake(0, 0, width_max, height_max);
        
        // 添加按钮
        if (_innerActions.count > 0)
        {
            CGSize contentSize = _actionsContainer.contentSize;
            UIEdgeInsets actionPadding = _actionsContainer.padding;

            CGFloat width_action = 0.0f, height_action = 0.0f;
            if (_flexDirection == YYBAlertViewFlexDirectionVertical)
            {
                width_action = MAX(contentSize.width, width_max);
                height_action = contentSize.height + height_max;

                _actionsContainer.frame = CGRectMake(actionPadding.left,
                                                     height_max + actionPadding.top,
                                                     width_action - actionPadding.right,
                                                     contentSize.height - actionPadding.bottom);

            }
            else if (_flexDirection == YYBAlertViewFlexDirectionHorizonal)
            {
                width_action = contentSize.width + width_max;
                height_action = MAX(contentSize.height,height_max);

                _actionsContainer.frame = CGRectMake(width_max + actionPadding.left,
                                                     actionPadding.top,
                                                     contentSize.width - actionPadding.right,
                                                     contentSize.height - actionPadding.bottom);

            }

            [_actionsContainer createContentViewsWithCalculationStatus:FALSE];
            _shadowView.frame = CGRectMake((CGRectGetWidth(self.frame) - width_action) / 2, (CGRectGetHeight(self.frame) - height_action) / 2, width_action, height_action);
            _contentView.frame = _shadowView.bounds;
        }
        else
        {
            _shadowView.frame = CGRectMake((CGRectGetWidth(self.frame) - width_max) / 2, (CGRectGetHeight(self.frame) - height_max) / 2, width_max, height_max);
            _contentView.frame = _shadowView.bounds;
        }
    }
    else
    {
        width_max = MAX(_minimalWidth, MIN(width_max, _maximalWidth));
        height_max = MAX(_minimalHeight, MIN(height_max, _maximalHeight));
        
        _contentSize = CGSizeMake(width_max, height_max);
    }
}

- (void)addLabelWithHandler:(void (^)(YYBAlertViewAction *, UILabel *))handler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleLabel];
        handler(action,action.label);
        
        [_innerViews addObject:action];
    }
}

- (void)addIconViewWithHandler:(void (^)(YYBAlertViewAction *, UIImageView *))handler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleImageView];
        handler(action,action.imageView);
        
        [_innerViews addObject:action];
    }
}

- (void)addTextFieldWithHandler:(void (^)(YYBAlertViewAction *, UITextField *))handler editingChangedHandler:(void (^)(NSString *))editHandler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleTextField];
        action.stringHandler = editHandler;
        handler(action,action.textField);
        
        [_innerViews addObject:action];
    }
}

- (void)addTextViewWithHandler:(void (^)(YYBAlertViewAction *, YYBAlertPlaceholderTextView *))handler editingChangedHandler:(void (^)(NSString *))editHandler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleTextView];
        action.stringHandler = editHandler;
        handler(action,action.textView);
        
        [_innerViews addObject:action];
    }
}

- (void)addButtonWithHandler:(void (^)(YYBAlertViewAction *, UIButton *))handler tapedOnHandler:(void (^)(void))tapedOnHandler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleButton];
        action.actionBlankHandler = tapedOnHandler;
        handler(action,action.button);
        
        [_innerViews addObject:action];
    }
}

- (void)addCustomView:(UIView *)customView configureHandler:(void (^)(YYBAlertViewAction *, UIView *))handler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleCustomView];
        if (customView)
        {
            action.view = customView;
        }
        
        handler(action,action.view);

        [_innerViews addObject:action];
    }
}

- (void)addActionWithHandler:(void (^)(YYBAlertViewAction *, UIButton *))handler tapedOnHandler:(void (^)(NSInteger))tapedOnHandler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleAction];
        action.actionHandler = tapedOnHandler;
        action.index = _innerActions.count;
        handler(action,action.button);
        
        __weak typeof(self) wself = self;
        [_actionsContainer addButtonWithHandler:handler tapedOnHandler:^{
            if (tapedOnHandler)
            {
                tapedOnHandler(action.index);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBALERTVIEW_ACTION_NOTIFICATION" object:nil userInfo:@{@"hash":@(wself.hash)}];
        }];
        [_innerActions addObject:action];
    }
}

- (void)addActivityIndicatorWithHandler:(void (^)(YYBAlertViewAction *, UIActivityIndicatorView *))handler
{
    if (handler)
    {
        YYBAlertViewAction *action = [[YYBAlertViewAction alloc] initWithStyle:YYBAlertViewActionStyleActivityIndicator];
        handler(action,action.indicator);
        
        [_innerViews addObject:action];
    }
}

- (void)addContainerViewWithHandler:(void (^)(YYBAlertViewContainer *))handler
{
    if (handler)
    {
        YYBAlertViewContainer *container = [[YYBAlertViewContainer alloc] init];
        handler(container);
        
        [_innerViews addObject:container];
    }
}

@end
