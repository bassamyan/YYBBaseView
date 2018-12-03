//
//  UILabel+YYBLayout.m
//  YYBCategory
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import "UILabel+YYBLayout.h"

@implementation UILabel (YYBLayout)

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font superView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint configureHandler:(void (^)(UILabel *))configureHandler {
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    if (superView) {
        [superView addSubview:label];
        if (constraint) {
            [label mas_makeConstraints:constraint];
        }
        if (configureHandler) {
            configureHandler(label);
        }
    }
    return label;
}

@end
