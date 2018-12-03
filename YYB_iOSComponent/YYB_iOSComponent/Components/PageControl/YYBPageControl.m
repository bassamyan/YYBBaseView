//
//  YYBPageControl.m
//  YYB_iOSComponent
//
//  Created by Sniper on 16/7/27.
//  Copyright © 2016年 Univease Co., Ltd All rights reserved.
//

#import "YYBPageControl.h"
#import "UIColor+YYBAdd.h"

@implementation YYBPageControl

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    _currentPageIndicatorColor = [UIColor colorWithHexInteger:0xA3A3A3];
    _othersPageIndicatorColor = [UIColor colorWithHexInteger:0xE1E1E1];
    _sizeForPageIndicator = CGSizeMake(5, 5);
    _pageItemPadding = 5.0f;
    
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGSize size = _sizeForPageIndicator;
    
    CGFloat x = (w - size.width * _numbersOfPages - _pageItemPadding * (_numbersOfPages - 1)) / 2;
    CGFloat y = h / 2;
    
    for (int i = 0; i < _numbersOfPages; i++) {
        switch (_type) {
            case YYBPageControlTypeCircle: {
                CGContextMoveToPoint(context, x + (size.width + _pageItemPadding) * i + size.width / 2, y);
                CGContextAddArc(context, x + (size.width + _pageItemPadding) * i + size.width / 2, y, size.width / 2, 0, M_PI * 2, NO);
                CGContextSetFillColorWithColor(context, i == _currentPage ? _currentPageIndicatorColor.CGColor : _othersPageIndicatorColor.CGColor);
                CGContextDrawPath(context, kCGPathFill);
            }
                break;
            case YYBPageControlTypeRect: {
                CGRect frame = CGRectMake(x + i * (size.width + _pageItemPadding),
                                          y - size.height / 2,
                                          size.width,
                                          size.height);
                CGContextSetFillColorWithColor(context, i == _currentPage ? _currentPageIndicatorColor.CGColor : _othersPageIndicatorColor.CGColor);
                CGContextStrokeRect(context,frame);
                CGContextFillRect(context, frame);
            }
                break;
            default:
                break;
        }
    }
    
    CGContextStrokePath(context);
}

@end
