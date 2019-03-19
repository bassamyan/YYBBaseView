//
//  UIView+Responder.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/23.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "UIView+Responder.h"

@implementation UIView (Responder)

- (UIView *)searchKeyboardResponder {
    for (UIView *subview in self.subviews)
    {
        if (subview.isFirstResponder)
        {
            return subview;
        }
        else
        {
            // 遍历子视图查看是否有响应者
            UIView *responder = [subview searchKeyboardResponder];
            if (responder)
            {
                return responder;
            }
        }
    }
    return nil;
}

- (void)removeSubViews
{
    for (UIView *subView in self.subviews)
    {
        [subView removeSubViews];
        [subView removeFromSuperview];
    }
}

@end
