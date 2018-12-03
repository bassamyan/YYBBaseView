//
//  YYBRouter.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2017/11/24.
//  Copyright © 2017年 Univease Co., Ltd All rights reserved.
//

#import "YYBRouter.h"
#import "UIViewController+YYBRouter.h"

@implementation YYBRouter

+ (YYBRouter *)shared {
    static YYBRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[YYBRouter alloc] init];
    });
    return router;
}

- (NSString *)_checkMapedViewController:(NSString *)domain {
    if (!domain) {
        return nil;
    }
    
    if (self.mapppedHandler) {
        NSString *mapped = self.mapppedHandler(domain);
        if (mapped != nil) {
            return mapped;
        }
    }
    
    if (!_mappedDictionary || _mappedDictionary.count == 0) {
        return nil;
    }
    
    if ([_mappedDictionary.allKeys containsObject:domain]) {
        return [_mappedDictionary objectForKey:domain];
    }
    
    return nil;
}

+ (void)openURL:(NSString *)URLString {
    [self openURL:URLString configureHandler:nil];
}

+ (void)openURL:(NSString *)URLString configureHandler:(void (^)(id))configureHandler {
    [self openURL:URLString configureHandler:configureHandler appearType:YYBRouterAppearTypePush];
}

+ (void)openURL:(NSString *)URLString configureHandler:(void (^)(id))configureHandler appearType:(YYBRouterAppearType)appearType {
    [self openURL:URLString configureHandler:configureHandler parameters:nil isAnimated:TRUE appearType:appearType];
}

+ (void)openURL:(NSString *)URLString configureHandler:(void(^)(id))configureHandler parameters:(NSDictionary *)parameters isAnimated:(BOOL)isAnimated appearType:(YYBRouterAppearType)appearType {
    if ([URLString hasPrefix:YYBRouterProtocol]) { // 是否协议包含协议
        NSString *domain = [URLString substringFromIndex:YYBRouterProtocol.length];
        NSString *controller = [[YYBRouter shared] _checkMapedViewController:domain];
        if (controller) {
            UIViewController *topViewController = [self topViewController];
            UIViewController *vc = [self _generateViewControllerWithClassType:controller parameters:parameters];
            if (configureHandler) {
                configureHandler(vc);
            }
            [self _animateViewController:vc actionViewController:topViewController isAnimated:isAnimated appearType:appearType];
        }
        
        NSArray *prefix = [domain componentsSeparatedByString:@"#"];
        if (prefix && prefix.count > 0) {
            // 确定打开类型
            NSString *opentype = prefix.firstObject;
            if ([opentype isEqualToString:@"class"]) {
                NSString *domain_parameter_string = [domain substringFromIndex:6];
                NSArray *domain_parameters = [domain_parameter_string componentsSeparatedByString:@"&"];
                NSString *domain_vc_name = [self stringFromViewControllerName:[domain_parameters firstObject]];
                
                UIViewController *topViewController = [self topViewController];
                UIViewController *vc = [self _generateViewControllerWithClassType:domain_vc_name parameters:parameters];
                if (configureHandler) {
                    configureHandler(vc);
                }
                [self _animateViewController:vc actionViewController:topViewController isAnimated:isAnimated appearType:appearType];
            }
        }
    }
}

+ (UIViewController *)_generateViewControllerWithClassType:(NSString *)classType parameters:(NSDictionary *)parameters {
    if (classType == nil && parameters == nil) {
        return nil;
    }
    
    id controller = [[NSClassFromString(classType) alloc] init];
    if (controller) {
        if (parameters && parameters.allKeys.count > 0) {
            [controller yr_assignValues:parameters];
        }
    }
    return controller;
}

+ (void)_animateViewController:(UIViewController *)controller actionViewController:(UIViewController *)actionViewController isAnimated:(BOOL)isAnimated appearType:(YYBRouterAppearType)appearType {
    switch (appearType) {
        case YYBRouterAppearTypePush: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [actionViewController.navigationController pushViewController:controller animated:isAnimated];
            });
        }
            break;
        case YYBRouterAppearTypePresent: {
            [actionViewController presentViewController:controller animated:isAnimated completion:nil];
        }
            break;
        case YYBRouterAppearTypePresentWithNavigation: {
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
            [actionViewController presentViewController:navi animated:isAnimated completion:nil];
        }
            break;
        default:
            break;
    }
}

+ (void)dismissViewControllers:(NSInteger)pageNumber {
    UINavigationController *navi = [self topViewController].navigationController;
    NSArray *vcs = [navi viewControllers];
    if (vcs.count > pageNumber) {
        UIViewController *vc = [vcs objectAtIndex:vcs.count - pageNumber - 1];
        [navi popToViewController:vc animated:YES];
    }
}

+ (NSString *)stringFromViewControllerName:(NSString *)name {
    return [NSString stringWithFormat:@"%@%@",name,YYBRouterClassSuffix];
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
