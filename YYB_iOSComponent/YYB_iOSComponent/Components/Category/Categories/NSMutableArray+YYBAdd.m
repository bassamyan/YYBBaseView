//
//  NSMutableArrayYYBAdd.m
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import "NSMutableArray+YYBAdd.h"

@implementation NSMutableArray (YYBAdd)

- (BOOL)isEmpty {
    return self.count == 0;
}

- (void)safeAddObject:(id)object {
    if (object) {
        [self addObject:object];
    }
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index {
    if (object) {
        [self insertObject:object atIndex:index];
    }
}

@end
