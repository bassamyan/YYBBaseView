//
//  UIGestureRecognizer+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (YYBAdd)

+ (instancetype)recognizerWithHandler:(void (^)(UIGestureRecognizer *gesture))handler;
- (instancetype)initWithHandler:(void (^)(UIGestureRecognizer *gesture))handler;

@end
