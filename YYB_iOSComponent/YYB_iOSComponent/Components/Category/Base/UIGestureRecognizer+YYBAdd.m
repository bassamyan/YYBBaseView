//
//  UIGestureRecognizer+YYBAdd.m
//  YYBCategory
//
//  Created by Aokura on 2018/9/4.
//  Copyright © 2018年 UnderTree,Inc. All rights reserved.
//

#import "UIGestureRecognizer+YYBAdd.h"
#import <objc/runtime.h>

static const void *YYBRecognizerHandlerKey = &YYBRecognizerHandlerKey;

@interface UIGestureRecognizer ()

@property (nonatomic,copy) void (^ recognizerHandler)(UIGestureRecognizer *recognier);

@end

@implementation UIGestureRecognizer (YYBAdd)

+ (instancetype)recognizerWithHandler:(void (^)(UIGestureRecognizer *))handler
{
    return [[[self class] alloc] initWithHandler:handler];
}

- (instancetype)initWithHandler:(void (^)(UIGestureRecognizer *))handler
{
    self = [self initWithTarget:self action:@selector(handleAtion:)];
    if (!self) return nil;
    
    self.recognizerHandler = handler;
    
    return self;
}

- (void)handleAtion:(UIGestureRecognizer *)recognizer
{
    if (self.recognizerHandler) {
        self.recognizerHandler(recognizer);
    }
}

- (void)setRecognizerHandler:(void (^)(UIGestureRecognizer *))recognizerHandler
{
    objc_setAssociatedObject(self, YYBRecognizerHandlerKey, recognizerHandler, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIGestureRecognizer *))recognizerHandler
{
    return objc_getAssociatedObject(self, YYBRecognizerHandlerKey);
}

@end
