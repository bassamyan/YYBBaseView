//
//  NSMutableArray+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
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
