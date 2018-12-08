//
//  YYBNavigationBarControl.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/28.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarControl.h"

@implementation YYBNavigationBarControl
{
    NSDictionary *_defaultAttributes;
    NSMutableDictionary *_cachedLabelColors;
    NSMutableDictionary *_cachedLabelFonts;
    CGSize _defaultIconSize;
    NSMutableDictionary *_cachedTitles;
    NSMutableDictionary *_cachedImages;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _defaultAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    _cachedLabelColors = [NSMutableDictionary new];
    _cachedLabelFonts = [NSMutableDictionary new];
    _cachedImages = [NSMutableDictionary new];
    _cachedTitles = [NSMutableDictionary new];
    
    [_cachedLabelFonts setObject:[UIFont systemFontOfSize:16.0f] forKey:@(UIControlStateNormal)];
    [_cachedLabelColors setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    _iconView = [UIImageView new];
    [self addSubview:_iconView];
    
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];

    return self;
}

- (CGSize)imageSize
{
    if (CGSizeEqualToSize(CGSizeZero, _imageSize))
    {
        return _defaultIconSize;
    }
    return _imageSize;
}

- (CGSize)contentSize
{
    CGFloat icon_horizonal_width = _iconEdgeInsets.left + _iconEdgeInsets.right;
    CGFloat icon_vertical_height = _iconEdgeInsets.top + _iconEdgeInsets.bottom;
    
    CGFloat label_horizonal_width = _labelEdgeInsets.left + _labelEdgeInsets.right;
    CGFloat label_vertical_height = _labelEdgeInsets.top + _labelEdgeInsets.bottom;
    
    CGFloat horizonal_width = icon_horizonal_width + label_horizonal_width;
    CGFloat vertical_height = icon_vertical_height + label_vertical_height;
    
    [self configureContent];
    [_label sizeToFit];
    
    CGFloat label_width = CGRectGetWidth(_label.frame);
    CGFloat label_height = CGRectGetHeight(_label.frame);
    
    switch (_style)
    {
        case YYBNavigationBarControlStyleCenter:
        {
            return CGSizeMake(MAX(label_width + label_horizonal_width, self.imageSize.width + icon_horizonal_width),
                              MAX(CGRectGetHeight(_label.frame) + label_vertical_height, self.imageSize.height + icon_vertical_height));
        }
            break;
        case YYBNavigationBarControlStyleTop:
        {
            return CGSizeMake(MAX(label_width + label_horizonal_width, self.imageSize.width + icon_horizonal_width),
                              label_height + _imageSize.height + vertical_height);
        }
            break;
        case YYBNavigationBarControlStyleBottom:
        {
            return CGSizeMake(MAX(label_width + label_horizonal_width, self.imageSize.width + icon_horizonal_width),
                              label_height + _imageSize.height + vertical_height);
        }
            break;
        case YYBNavigationBarControlStyleLeft:
        {
            return CGSizeMake(label_width + _imageSize.width + horizonal_width,
                              MAX(label_height + label_vertical_height, self.imageSize.height + icon_vertical_height));
        }
            break;
        case YYBNavigationBarControlStyleRight:
        {
            return CGSizeMake(label_width + _imageSize.width + horizonal_width,
                              MAX(label_height + label_vertical_height, self.imageSize.height + icon_vertical_height));
        }
            break;
        default:
            break;
    }
}

- (void)configureContent
{
    UIImage *icon = [_cachedImages objectForKey:@(_controlState)];
    if (icon == nil)
    {
        icon = [_cachedImages objectForKey:@(UIControlStateNormal)];
    }
    
    NSString *title = [_cachedTitles objectForKey:@(_controlState)];
    if (title == nil)
    {
        title = [_cachedTitles objectForKey:@(UIControlStateNormal)];
    }
    
    UIColor *textColor = [_cachedLabelColors objectForKey:@(_controlState)];
    if (textColor == nil)
    {
        textColor = [_cachedLabelColors objectForKey:@(UIControlStateNormal)];
        
        if (textColor == nil)
        {
            textColor = [_defaultAttributes objectForKey:NSForegroundColorAttributeName];
        }
    }
    
    UIFont *textFont = [_cachedLabelFonts objectForKey:@(_controlState)];
    if (textFont == nil)
    {
        textFont = [_cachedLabelFonts objectForKey:@(UIControlStateNormal)];
        
        if (textFont)
        {
            textFont = [_defaultAttributes objectForKey:NSFontAttributeName];
        }
    }
    
    _iconView.image = icon;
    _label.textColor = textColor;
    _label.font = textFont;
    _label.text = title;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self configureContent];
    
    [_label sizeToFit];
    CGSize labelSize = _label.frame.size;
    
    CGFloat label_horizonal = _labelEdgeInsets.left;
    CGFloat label_vertical = _labelEdgeInsets.top;
    CGFloat icon_horizonal = _iconEdgeInsets.left;
    CGFloat icon_vertical = _iconEdgeInsets.top;
    
    CGFloat width_icon = CGRectGetWidth(self.frame) - _iconEdgeInsets.left - _iconEdgeInsets.right;
    CGFloat height_icon = CGRectGetHeight(self.frame) - _iconEdgeInsets.top - _iconEdgeInsets.bottom;
    
    CGFloat width_label = CGRectGetWidth(self.frame) - _labelEdgeInsets.left - _labelEdgeInsets.right;
    CGFloat height_label = CGRectGetHeight(self.frame) - _labelEdgeInsets.top - _labelEdgeInsets.bottom;
    
    switch (_style)
    {
        case YYBNavigationBarControlStyleCenter:
        {
            _iconView.frame = CGRectMake((width_icon - _imageSize.width) / 2 + icon_horizonal, (height_icon - _imageSize.height) / 2 + icon_vertical, _imageSize.width, _imageSize.height);
            _label.frame = CGRectMake((width_label - labelSize.width) / 2 + _labelEdgeInsets.left + _iconEdgeInsets.right , (height_label - labelSize.height) / 2 + _labelEdgeInsets.top + _iconEdgeInsets.bottom, labelSize.width, labelSize.height);
        }
            break;
        case YYBNavigationBarControlStyleTop:
        {
            _iconView.frame = CGRectMake((width_icon - _imageSize.width) / 2 + icon_horizonal, icon_vertical, _imageSize.width, _imageSize.height);
            _label.frame = CGRectMake((width_label - labelSize.width) / 2 + label_horizonal, CGRectGetMaxY(_iconView.frame) + _labelEdgeInsets.top +
                                      _iconEdgeInsets.bottom, labelSize.width, labelSize.height);
        }
            break;
        case YYBNavigationBarControlStyleBottom:
        {
            _iconView.frame = CGRectMake((width_icon - _imageSize.width) / 2 + icon_horizonal, height_icon + icon_vertical - _imageSize.height, _imageSize.width, _imageSize.height);
            _label.frame = CGRectMake((width_label - labelSize.width) / 2 + label_horizonal, CGRectGetMinY(_iconView.frame) - _labelEdgeInsets.bottom - labelSize.height - _iconEdgeInsets.top, labelSize.width, labelSize.height);
        }
            break;
        case YYBNavigationBarControlStyleLeft:
        {
            _iconView.frame = CGRectMake(icon_horizonal, (height_icon - _imageSize.height) / 2 + icon_vertical, _imageSize.width, _imageSize.height);
            _label.frame = CGRectMake(CGRectGetMaxX(_iconView.frame) + _labelEdgeInsets.left + _iconEdgeInsets.left + _iconEdgeInsets.right, (height_label - labelSize.height) / 2 + label_vertical , labelSize.width, labelSize.height);
        }
            break;
        case YYBNavigationBarControlStyleRight:
        {
            _iconView.frame = CGRectMake(width_icon - icon_horizonal - _imageSize.width, (height_icon - _imageSize.height) / 2 + icon_vertical, _imageSize.width, _imageSize.height);
            _label.frame = CGRectMake(CGRectGetMinX(_iconView.frame) - _labelEdgeInsets.right - labelSize.width - _iconEdgeInsets.left, (height_label - labelSize.height) / 2 + label_vertical, labelSize.width, labelSize.height);
        }
            break;
        default:
            break;
    }
}

- (void)setBarButtonTextFont:(UIFont *)textFont controlState:(UIControlState)state
{
    if (textFont)
    {
        [_cachedLabelFonts setObject:textFont forKey:@(state)];
    }
}

- (void)setBarButtonTextColor:(UIColor *)textColor controlState:(UIControlState)state
{
    if (textColor)
    {
        [_cachedLabelColors setObject:textColor forKey:@(state)];
    }
}

- (void)setBarButtonImage:(UIImage *)image controlState:(UIControlState)state
{
    if (image)
    {
        [_cachedImages setObject:image forKey:@(state)];
    }
}

- (void)setBarButtonTitle:(NSString *)title controlState:(UIControlState)state
{
    if (title)
    {
        [_cachedTitles setObject:title forKey:@(state)];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected && _controlState == UIControlStateSelected) return;
    if (!selected && _controlState == UIControlStateNormal) return;
    
    _controlState = selected ? UIControlStateSelected : UIControlStateNormal;
    [self _updateContent];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_controlState != UIControlStateSelected)
    {
        _controlState = UIControlStateHighlighted;
        [self _updateContent];
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_controlState == UIControlStateHighlighted)
    {
        _controlState = UIControlStateNormal;
        [self _updateContent];
    }
}

- (void)_updateContent
{
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

@end
