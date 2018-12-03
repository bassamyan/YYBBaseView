//
//  YYBRefreshSpotTopView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/12/23.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRefreshSpotTopView.h"

@implementation YYBRefreshSpotTopView {
    NSInteger _countingProgress;
    NSInteger _maxProgress;
    CGFloat _blueProgress, _redProgress, _greenProgress;
    
    CADisplayLink *_scheduler;
    NSTimeInterval _animateDuration;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithScrollView:scrollView];
    if (!self) return nil;
    
    _maxProgress = 120;
    
    return self;
}

- (void)statusDidChanged:(YYBRefreshStatus)status {
    switch (status) {
        case YYBRefreshStatusInitial: {
            [_scheduler invalidate];
            _scheduler = nil;
            _countingProgress = 0;
            [self setNeedsDisplay];
        }
            break;
        case YYBRefreshStatusPulling: {
            
        }
            break;
        case YYBRefreshStatusRefreshing: {
            _scheduler = [CADisplayLink displayLinkWithTarget:self selector:@selector(schedulerAction)];
            [_scheduler addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            _scheduler.frameInterval = 1.0f;
        }
            break;
            
        default:
            break;
    }
}

// 1/3的时间处于不变状态,2/3的时间处于变化状态
- (void)schedulerAction {
    _countingProgress ++;
    NSInteger progressOffset = _countingProgress % _maxProgress;
    if (progressOffset < _maxProgress / 3) {
        _blueProgress = (CGFloat)progressOffset / (_maxProgress / 3);
        _redProgress = 0.0f;
        _greenProgress = 1 - (CGFloat)progressOffset / (_maxProgress / 3);
    } else if (progressOffset >= _maxProgress / 3 && progressOffset < _maxProgress * 2 / 3) {
        _blueProgress = 1 - (CGFloat)(progressOffset - _maxProgress / 3) / (_maxProgress / 3);
        _redProgress = (CGFloat)(progressOffset - _maxProgress / 3) / (_maxProgress / 3);
        _greenProgress = 0.0f;
    } else if (progressOffset >= _maxProgress * 2 / 3 && progressOffset < _maxProgress) {
        _blueProgress = 0.0f;
        _redProgress = 1 - (CGFloat)(progressOffset - _maxProgress * 2 / 3) / (_maxProgress / 3);
        _greenProgress = (CGFloat)(progressOffset - _maxProgress * 2 / 3) / (_maxProgress / 3);
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 各个圆圈之间的距离
    CGFloat itemOffset = 7.0;
    
    // 圆圈最小的大小
    CGFloat itemMinSize = 6.0f;
    // 圆圈最大的大小
    CGFloat itemMaxSize = 12.0f;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(context, 0.0f);
    
    // 蓝圈
    CGFloat blueCircleSize = itemMinSize / 2 + (itemMaxSize - itemMinSize) * _blueProgress / 2;
    CGPoint blueCenterPoint = CGPointMake(width / 2 - itemOffset - itemMinSize, height / 2);
    CGContextMoveToPoint(context, blueCenterPoint.x, blueCenterPoint.y);
    CGContextSetFillColorWithColor(context, [self colorWithHexInteger:0x4dd3ff].CGColor);
    CGContextAddArc(context, blueCenterPoint.x, blueCenterPoint.y, blueCircleSize, 0, M_PI * 2, NO);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 红圈
    CGFloat redCircleSize = itemMinSize / 2 + (itemMaxSize - itemMinSize) * _redProgress / 2;
    CGPoint redCenterPoint = CGPointMake(width / 2, height / 2);
    CGContextMoveToPoint(context, redCenterPoint.x, redCenterPoint.y);
    CGContextSetFillColorWithColor(context, [self colorWithHexInteger:0xff624d].CGColor);
    CGContextAddArc(context, redCenterPoint.x, redCenterPoint.y, redCircleSize, 0, M_PI * 2, NO);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 绿圈
    CGFloat greenCircleSize = itemMinSize / 2 + (itemMaxSize - itemMinSize) * _greenProgress / 2;
    CGPoint greenCenterPoint = CGPointMake(width / 2 + itemOffset + itemMinSize, height / 2);
    CGContextMoveToPoint(context, greenCenterPoint.x, greenCenterPoint.y);
    CGContextSetFillColorWithColor(context, [self colorWithHexInteger:0xbff057].CGColor);
    CGContextAddArc(context, greenCenterPoint.x, greenCenterPoint.y, greenCircleSize, 0, M_PI * 2, NO);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (UIColor *)colorWithHexInteger:(NSUInteger)hexInteger {
    CGFloat red, green, blue, alpha;
    
    red = ((CGFloat)((hexInteger >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hexInteger >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hexInteger >> 0) & 0xFF)) / ((CGFloat)0xFF);
    alpha = hexInteger > 0xFFFFFF ? ((CGFloat)((hexInteger >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
