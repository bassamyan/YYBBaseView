//
//  UITextField+YYBLayout.h
//  YYBCategory
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UITextField (YYBLayout)

+ (UITextField *)textFieldSuperView:(UIView *)superView
                         constraint:(void(^)(MASConstraintMaker *make))constraint
                   configureHandler:(void(^)(UITextField *textField))configureHandler;

@end
