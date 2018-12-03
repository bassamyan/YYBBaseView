//
//  UIButton+YYBLayout.m
//  YYBCategory
//
//  Created by Aokura on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import "UIButton+YYBLayout.h"
#import <objc/runtime.h>

static const void *YYBTapedHandlerKey = &YYBTapedHandlerKey;

@interface UIButton ()
@property (nonatomic,copy) void (^ tapedHandler)(UIButton *sender);

@end

@implementation UIButton (YYBLayout)

+ (instancetype)buttonWithSuperView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint configureButtonHandler:(void (^)(UIButton *))configureButtonHandler {
    UIButton *button = [UIButton new];
    if (superView) {
        [superView addSubview:button];
        
        if (constraint) {
            [button mas_makeConstraints:constraint];
        }
        if (configureButtonHandler) {
            configureButtonHandler(button);
        }
    }
    return button;
}

+ (instancetype)buttonWithSuperView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint configureButtonHandler:(void (^)(UIButton *))configureButtonHandler tapedHandler:(void (^)(UIButton *))tapedHandler {
    UIButton *view = [UIButton buttonWithSuperView:superView constraint:constraint configureButtonHandler:configureButtonHandler];
    if (view) {
        if (tapedHandler) {
            view.tapedHandler = tapedHandler;
        }
        [view addTarget:view action:@selector(buttonActionHandler:) forControlEvents:1<<6];
    }
    return view;
}

- (void)buttonActionHandler:(UIButton *)sender {
    if (self.tapedHandler) {
        self.tapedHandler(sender);
    }
}

- (void)setTapedHandler:(void (^)(UIButton *))tapedHandler {
    objc_setAssociatedObject(self, YYBTapedHandlerKey, tapedHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))tapedHandler {
    return objc_getAssociatedObject(self, YYBTapedHandlerKey);
}

@end
