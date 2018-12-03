//
//  NSMutableArray+YYBAdd.h
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (YYBAdd)

// 是否空数组
- (BOOL)isEmpty;

// 可变数组加数据
- (void)safeAddObject:(id)object;

// 可变数组插入数据
- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index;

@end
