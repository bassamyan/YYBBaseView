//
//  NSArray+YYBAdd.h
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYBAdd)

- (BOOL)isEmpty;
- (id)safeObjectAtIndex:(NSUInteger)index;

- (NSArray *)reversely; // 倒序输出所有元素

- (NSArray *)sort;
- (NSArray *)sort:(id(^)(id obj))handler;
- (NSArray *)sortReversely;
- (NSArray *)sortCaseInsensitive; // 元素按照ascii码进行排序,大小写敏感

- (NSArray *)union:(NSArray *)anArray;
- (NSArray *)intersection:(NSArray *)anArray;
- (NSArray *)difference:(NSArray *)anArray;

- (NSArray *)first:(NSInteger)count; // 获取前count个数据
- (NSArray *)takeWhile:(BOOL(^)(id obj))handler; // 根据条件获取
- (NSArray *)reject:(BOOL(^)(id obj))handler; // 根据条件筛选
- (NSArray *)distinct; // 去重
- (NSArray *)map:(id(^)(id obj, NSInteger index))handler;
- (NSArray *)compact:(id(^)(id obj, NSInteger index))handler; // 与map相同,但是不会添加NSNull
- (NSArray *(^)(NSUInteger start, NSUInteger length))slice; // 分割数组
- (NSArray *(^)(NSUInteger))last; // 最后几个数据组成一个数组
- (id(^)(id (^)(id memo, id obj)))reduce;

- (void)each:(void (^)(id obj))handler;
- (id)match:(BOOL (^)(id obj))handler;

- (id(^)(id))min;
- (id(^)(id))max;

@property (nonatomic,readonly) id secondObject;
@property (nonatomic,readonly) id thirdObject;

@end
