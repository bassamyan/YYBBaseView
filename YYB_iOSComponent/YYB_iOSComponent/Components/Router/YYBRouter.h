//
//  YYBRouter.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/24.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YYBRouterAppearType) {
    // 正常
    YYBRouterAppearTypePush,
    // 弹出
    YYBRouterAppearTypePresent,
    // 弹出并带有一个导航栏控制器
    YYBRouterAppearTypePresentWithNavigation,
};

static NSString * const YYBRouterProtocol = @"yyb://";
static NSString * const YYBRouterClassSuffix = @"ViewController";

typedef void (^ YYBRouterCompletionHandler)(id routerObject);

@interface YYBRouter : NSObject

+ (YYBRouter *)shared;
@property (nonatomic,strong) NSDictionary *mappedDictionary;
@property (nonatomic,copy) NSString * (^ mapppedHandler)(NSString *protocol);

+ (void)openURL:(NSString *)URLString;
+ (void)openURL:(NSString *)URLString configureHandler:(void(^)(id controller))configureHandler;
+ (void)openURL:(NSString *)URLString configureHandler:(void(^)(id controller))configureHandler appearType:(YYBRouterAppearType)appearType;
+ (void)openURL:(NSString *)URLString configureHandler:(void(^)(id controller))configureHandler parameters:(NSDictionary *)parameters isAnimated:(BOOL)isAnimated appearType:(YYBRouterAppearType)appearType;

+ (void)dismissViewControllers:(NSInteger)pageNumber;
+ (UIViewController *)topViewController;

@end
