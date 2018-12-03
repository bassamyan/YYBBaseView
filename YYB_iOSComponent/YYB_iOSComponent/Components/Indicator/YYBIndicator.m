//
//  YYBIndicator.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/5/29.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBIndicator.h"

@implementation YYBIndicator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.activeTintColor = [UIColor grayColor];
        self.deactiveTintColor = [UIColor lightGrayColor];
        self.progress = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat progress = self.progress * width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, height);
    
    CGContextSetStrokeColorWithColor(context, self.activeTintColor.CGColor);
    CGContextMoveToPoint(context, 0, height / 2);
    CGContextAddLineToPoint(context, progress, height / 2);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetStrokeColorWithColor(context, self.deactiveTintColor.CGColor);
    CGContextMoveToPoint(context, progress, height / 2);
    CGContextAddLineToPoint(context, width, height / 2);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextStrokePath(context);
}

@end
