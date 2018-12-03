//
//  UIViewController+YYBRouter.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/5.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YYBRouter)

+ (BOOL)yr_searchClass:(Class)aClass hasProperty:(NSString *)property;
- (id)yr_assignValues:(NSDictionary *)valuesParams;

@end
