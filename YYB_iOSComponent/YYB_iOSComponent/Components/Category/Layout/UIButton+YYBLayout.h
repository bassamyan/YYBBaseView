//
//  UIButton+YYBLayout.h
//  YYBCategory
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIButton (YYBLayout)

+ (instancetype)buttonWithSuperView:(UIView *)superView
                       constraint:(void(^)(MASConstraintMaker *make))constraint
           configureButtonHandler:(void (^)(UIButton *button))configureButtonHandler;

+ (instancetype)buttonWithSuperView:(UIView *)superView
                         constraint:(void(^)(MASConstraintMaker *make))constraint
             configureButtonHandler:(void (^)(UIButton *button))configureButtonHandler
                       tapedHandler:(void (^)(UIButton *sender))tapedHandler;

@end
