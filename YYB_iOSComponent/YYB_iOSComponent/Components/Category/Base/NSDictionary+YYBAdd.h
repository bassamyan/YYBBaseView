//
//  NSDictionary+YYBAdd.h
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (YYBAdd)

- (BOOL)isEmpty;

- (void)each:(void (^)(KeyType,ObjectType))handler;
- (nullable id)match:(BOOL (^)(KeyType key, ObjectType obj))handler;
- (NSDictionary *)select:(BOOL (^)(KeyType key, ObjectType obj))handler;
- (NSDictionary *)reject:(BOOL (^)(KeyType key, ObjectType obj))handler;
- (NSDictionary *)map:(id (^)(KeyType key, ObjectType obj))handler;

/**
 按照URL拼接的方式进行拼接
 @return A=123&B=234&C=代码 ...
 */
- (NSString *)stringByURLAppending;

/**
 添加另外的字典的数据
 */
- (NSDictionary *)appendingParameters:(NSDictionary *)parameters;

/**
 根据文件名获取字典数据
 */
+ (NSDictionary *)toJSONObject:(NSString *)JSONFile;

@end
