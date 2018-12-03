//
//  UIColor+YYBAdd.h
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YYBAdd)

// 十六进制转化UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexInteger:(NSUInteger)hexInteger;
+ (UIColor *)colorWithHexInteger:(NSUInteger)hexInteger alpha:(CGFloat)alpha;

// 颜色转化成UIImage
- (UIImage *)colorImage;
- (UIImage *)colorImageWithSize:(CGSize)specSize;

@end
