//
//  NSDictionary+Sign.m
//  Mantu-iOS
//
//  Created by Aokura on 2018/8/1.
//  Copyright © 2018年 Mantu,Inc. All rights reserved.
//

#import "NSDictionary+Sign.h"

@implementation NSDictionary (Sign)

- (NSString *)dictTransformToJSONStringWithParameters:(NSDictionary *)parameters {
    if (parameters.allKeys.count == 0) {
        return @"{}";
    }
    
    NSArray *keys = [parameters.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSString *keyString = [NSString new];
    for (NSString *key in keys) {
        id value = [parameters objectForKey:key];
        NSString *keyAndValue = [NSString new];
        
        if ([value isKindOfClass:[NSString class]]) {
            keyAndValue = [NSString stringWithFormat:@"\"%@\":\"%@\",",key,value];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            keyAndValue = [NSString stringWithFormat:@"\"%@\":%@,",key,value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSString *keyAndValueArray = @"[";
            for (NSDictionary *parameters in value) {
                keyAndValueArray = [keyAndValueArray stringByAppendingString:[NSString stringWithFormat:@"%@,",[self dictTransformToJSONStringWithParameters:parameters]]];
            }
            keyAndValueArray = [keyAndValueArray substringToIndex:keyAndValueArray.length - 1];
            keyAndValueArray = [keyAndValueArray stringByAppendingString:@"]"];
            
            keyAndValue = [NSString stringWithFormat:@"\"%@\":%@,",key,keyAndValueArray];
        }
        keyString = [keyString stringByAppendingString:keyAndValue];
    }
    return [NSString stringWithFormat:@"{%@}",[keyString substringToIndex:keyString.length - 1]];
}

@end
