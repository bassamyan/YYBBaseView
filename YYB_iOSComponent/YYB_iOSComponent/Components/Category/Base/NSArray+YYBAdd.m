//
//  NSArrayYYBAdd.m
//  Framework
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "NSArray+YYBAdd.h"

@implementation NSArray (YYBAdd)

- (BOOL)isEmpty
{
    return (self.count == 0);
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count)
    {
        id object = [self objectAtIndex:index];
        if ([object isKindOfClass:[NSNull class]])
            return nil;
        return object;
    }
    return nil;
}

- (NSArray *)reversely
{
    if (self.count <= 1) {
        return self;
    }
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)sort {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSArray *)sort:(id (^)(id))handler
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [handler(obj1) compare:handler(obj2)];
    }];
}

- (NSArray *)sortReversely
{
    return [[self sort] reversely];
}

- (NSArray *)sortCaseInsensitive
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 caseInsensitiveCompare:obj2];
    }];
}

- (NSArray *)union:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 unionOrderedSet:set2];
    return set1.array.copy;
}

- (NSArray *)intersection:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 intersectOrderedSet:set2];
    return set1.array.copy;
}

- (NSArray *)difference:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 minusOrderedSet:set2];
    return set1.array.copy;
}

- (NSArray *)first:(NSInteger)count
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *stop = !(idx < count);
        if (!(*stop))
        {
            [result addObject:obj];
        }
    }];
    return result;
}

- (NSArray *)takeWhile:(BOOL (^)(id))handler
{
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return handler(obj);
    }]];
}

- (NSArray *)reject:(BOOL (^)(id))handler
{
    return [self takeWhile:^BOOL(id obj) {
        return !handler(obj);
    }];
}

- (NSArray *)distinct:(id (^)(id))handler
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([result objectForKey:handler(obj)] == nil)
        {
            [result setValue:obj forKey:handler(obj)];
        }
    }];
    return [result allValues];
}

- (NSArray *)distinct
{
    return [[self distinct:^id(id obj) {
        return obj;
    }] sort];
}

- (NSArray *)map:(id (^)(id, NSInteger))handler
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        id value = handler(obj,idx) ?: [NSNull null];
        [result addObject:value];
    }];
    
    return result;
}

- (NSArray *)compact:(id (^)(id, NSInteger))handler
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        id value = handler(obj,idx);
        if (value)
        {
            [result addObject:value];
        }
    }];
    
    return result;
}

- (void)each:(void (^)(id))handler
{
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        handler(obj);
    }];
}

- (id)match:(BOOL (^)(id obj))handler
{
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return handler(obj);
    }];
    
    if (index == NSNotFound)
    {
        return nil;
    }
    
    return self[index];
}

- (id (^)(id))min
{
    return ^(NSInteger (^block)(id o)) {
        NSInteger value = NSIntegerMax;
        id keeper = nil;
        for (id o in self)
        {
            NSInteger ov = block(o);
            if (ov < value)
            {
                value = ov;
                keeper = o;
            }
        }
        return keeper;
    };
}

- (id (^)(id))max
{
    return ^(NSInteger (^block)(id o)) {
        NSInteger value = NSIntegerMin;
        id keeper = nil;
        for (id o in self)
        {
            NSInteger ov = block(o);
            if (ov > value)
            {
                value = ov;
                keeper = o;
            }
        }
        return keeper;
    };
}

- (NSArray *(^)(NSUInteger, NSUInteger))slice
{
    return ^id(NSUInteger start, NSUInteger length) {
        NSUInteger const N = self.count;
        
        if (N == 0)
            return self;
        
        if (start > N - 1) start = N - 1;
        if (start + length > N) length = N - start;
        
        return [self subarrayWithRange:NSMakeRange(start, length)];
    };
}

- (NSArray *(^)(NSUInteger))last
{
    return ^(NSUInteger num) {
        return self.slice(self.count - num, num);
    };
}

- (id (^)(id (^)(id, id)))reduce
{
    return ^(id (^block)(id, id)) {
        id memo = self.firstObject;
        for (id obj in self.last(self.count - 1))
            memo = block(memo, obj);
        return memo;
    };
}

- (id)secondObject
{
    return [self safeObjectAtIndex:1];
}

- (id)thirdObject
{
    return [self safeObjectAtIndex:2];
}

@end
