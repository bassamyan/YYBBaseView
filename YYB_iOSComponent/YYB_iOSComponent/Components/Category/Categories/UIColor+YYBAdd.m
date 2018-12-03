//
//  UIColorYYBAdd.m
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import "UIColor+YYBAdd.h"

@implementation UIColor (YYBAdd)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [self colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6){
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R
    NSString *rString = [cString substringWithRange:range];
    //G
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //B
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexInteger:(NSUInteger)hexInteger {
    CGFloat red, green, blue, alpha;
    
    red = ((CGFloat)((hexInteger >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hexInteger >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hexInteger >> 0) & 0xFF)) / ((CGFloat)0xFF);
    alpha = hexInteger > 0xFFFFFF ? ((CGFloat)((hexInteger >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexInteger:(NSUInteger)hexInteger alpha:(CGFloat)alpha {
    return [[UIColor colorWithHexInteger:hexInteger] colorWithAlphaComponent:alpha];
}

- (UIImage *)colorImage {
    return [self colorImageWithSize:CGSizeMake(1, 1)];
}

- (UIImage *)colorImageWithSize:(CGSize)specSize {
    CGRect rect = CGRectMake(0, 0, specSize.width, specSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
