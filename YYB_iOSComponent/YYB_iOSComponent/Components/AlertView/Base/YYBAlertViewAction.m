//
//  YYBAlertViewAction.m
//  YYBAlertView
//
//  Created by Sniper on 2018/8/30.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlertViewAction.h"

@interface YYBAlertViewAction () <UITextViewDelegate>

@end

@implementation YYBAlertViewAction

- (instancetype)initWithStyle:(YYBAlertViewActionStyle)style {
    self = [super init];
    if (!self) return nil;
    
    _style = style;
    _padding = UIEdgeInsetsZero;
    
    switch (style)
    {
        case YYBAlertViewActionStyleUnknow:
        {
            
        }
            break;
        case YYBAlertViewActionStyleLabel:
        {
            _label = [UILabel new];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.numberOfLines = 0;
        }
            break;
        case YYBAlertViewActionStyleButton:
        {
            _button = [UIButton new];
            [_button addTarget:self action:@selector(buttonBlankAction:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case YYBAlertViewActionStyleTextField:
        {
            _textField = [UITextField new];
            [_textField addTarget:self action:@selector(textFieldEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
        }
            break;
        case YYBAlertViewActionStyleImageView:
        {
            _imageView = [UIImageView new];
        }
            break;
        case YYBAlertViewActionStyleCustomView:
        {
            _view = [UIView new];
        }
            break;
        case YYBAlertViewActionStyleAction:
        {
            _button = [UIButton new];
            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case YYBAlertViewActionStyleTextView:
        {
            _textView = [YYBAlertPlaceholderTextView new];
            _textView.delegate = self;
        }
            break;
        case YYBAlertViewActionStyleActivityIndicator:
        {
            _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
            break;
        default:
            break;
    }
    
    return self;
}

- (UIView *)actionView
{
    switch (self.style)
    {
        case YYBAlertViewActionStyleUnknow:
        {
            return nil;
        }
            break;
        case YYBAlertViewActionStyleLabel:
        {
            return self.label;
        }
            break;
        case YYBAlertViewActionStyleButton:
        {
            return self.button;
        }
            break;
        case YYBAlertViewActionStyleTextField:
        {
            return self.textField;
        }
            break;
        case YYBAlertViewActionStyleImageView:
        {
            return self.imageView;
        }
            break;
        case YYBAlertViewActionStyleCustomView:
        {
            return self.view;
        }
            break;
        case YYBAlertViewActionStyleAction:
        {
            return self.button;
        }
            break;
        case YYBAlertViewActionStyleTextView:
        {
            return self.textView;
        }
            break;
        case YYBAlertViewActionStyleActivityIndicator:
        {
            return self.indicator;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)textFieldEditingChangedAction:(UITextField *)textField
{
    if (self.stringHandler)
    {
        self.stringHandler(textField.text);
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.stringHandler)
    {
        self.stringHandler(textView.text);
    }
}

- (void)buttonBlankAction:(UIButton *)button
{
    if (self.actionBlankHandler)
    {
        self.actionBlankHandler();
    }
}

- (void)buttonAction:(UIButton *)button
{
    if (self.actionHandler)
    {
        self.actionHandler(_index);
    }
}

- (CGSize)labelSizeWithMaxWidth:(CGFloat)width
{
    CGSize size = [_label sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    if (CGSizeEqualToSize(_size, CGSizeZero))
    {
        return size;
    }
    else if (_size.width == 0.0f)
    {
        return CGSizeMake(size.width, _size.height);
    }
    else if (_size.height == 0.0f)
    {
        return CGSizeMake(_size.width, size.height);
    }
    else
    {
        return _size;
    }
}

- (CGSize)actionSizeWithContainerMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    if (CGSizeEqualToSize(CGSizeZero, _size))
    {
        return CGSizeZero;
    }
    else if (_size.width == 0.0f)
    {
        return CGSizeMake(maxWidth, _size.height);
    }
    else if (_size.height == 0.0f)
    {
        return CGSizeMake(_size.width, maxHeight);
    }
    else
    {
        return _size;
    }
}

@end
