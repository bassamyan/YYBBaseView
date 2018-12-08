//
//  NSBundle+YYBAdd.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/8.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "NSBundle+YYBAdd.h"

@implementation NSBundle (YYBAdd)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName
{
    NSString *bundle = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *path = [bundle stringByAppendingPathComponent:imageName];
    
    return [UIImage imageWithContentsOfFile:path];
}

@end
