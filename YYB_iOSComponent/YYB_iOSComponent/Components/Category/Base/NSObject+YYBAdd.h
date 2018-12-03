//
//  NSObject+YYBAdd.h
//  Framework
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YYBAdd)

// 获取类中的所有参数
+ (NSArray *)properties;

// 获取类中的一个属性的值
- (id)valueOfKey:(NSString *)key;

// 完全复制一个类
- (id)objectCopy;

// 搜索一个类中是否有该属性名
+ (BOOL)searchClass:(Class)aClass hasProperty:(NSString *)property;

// 对一个对象进行赋值
- (id)assignValues:(NSDictionary *)valuesParams;

// 根据名称初始化一个对象
+ (id)initWithClassName:(NSString *)aClass params:(NSDictionary *)params;

// 拨打电话
+ (void)makePhoneCall:(NSString *)phoneNumber;

// 打开一个网页链接
+ (void)openURL:(NSString *)URL;

// 跳转系统协议
+ (void)openSystemURL:(NSString *)URL;

// 获取当前设备型号
+ (NSString *)device_type;

// 获取对外版本号
+ (NSString *)shortVersion;

// 获取包名
+ (NSString *)bundleIdentifier;

@end
