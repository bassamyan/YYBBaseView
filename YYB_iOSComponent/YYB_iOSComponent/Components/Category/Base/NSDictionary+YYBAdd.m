//
//  NSDictionaryYYBAdd.m
//  Framework
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "NSDictionary+YYBAdd.h"
#import "NSArray+YYBAdd.h"

@implementation NSDictionary (YYBAdd)

- (BOOL)isEmpty
{
    return self.allKeys.count == 0;
}

- (void)each:(void (^)(id, id))handler
{
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        handler(key,obj);
    }];
}

- (id)match:(BOOL (^)(id key, id obj))handler
{
    return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        if (handler(key, obj)) {
            *stop = YES;
            return YES;
        }
        
        return NO;
    }] anyObject]];
}

- (NSDictionary *)select:(BOOL (^)(id key, id obj))handler
{
    NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return handler(key, obj);
    }] allObjects];
    
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)reject:(BOOL (^)(id key, id obj))handler
{
    NSParameterAssert(handler != nil);
    return [self select:^BOOL(id key, id obj) {
        return !handler(key, obj);
    }];
}

- (NSDictionary *)map:(id (^)(id key, id obj))handler
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self each:^(id key, id obj) {
        id value = handler(key, obj) ?: [NSNull null];
        result[key] = value;
    }];
    
    return result;
}

- (NSString *)stringByURLAppending {
    if (self.allKeys.count == 0) return @"";
    
    NSString *string = @"";
    for (NSString *key in [self.allKeys sort]) {
        id value = [self objectForKey:key];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,value]];
    }
    return [string substringToIndex:string.length - 1];
}

- (NSDictionary *)appendingParameters:(NSDictionary *)parameters {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in parameters.allKeys) {
        id value = [parameters objectForKey:key];
        [parameter setObject:value forKey:key];
    }
    return parameter;
}

+ (NSDictionary *)toJSONObject:(NSString *)JSONFile {
    if (JSONFile) {
        NSData *resultData = [JSONFile dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary * result = [NSJSONSerialization JSONObjectWithData:resultData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error];
        if (error) {
            NSLog(@"toJSONObject error = %@",error);
        }
        return result;
    }
    return nil;
}

@end
