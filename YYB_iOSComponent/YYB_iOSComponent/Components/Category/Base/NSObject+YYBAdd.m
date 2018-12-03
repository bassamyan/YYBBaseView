//
//  NSObjectYYBAdd.m
//  Framework
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "NSObject+YYBAdd.h"
#import <objc/runtime.h>
#import "sys/utsname.h"
#import <UIKit/UIKit.h>

@implementation NSObject (YYBAdd)

+ (NSArray *)properties {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self, &count);
    NSMutableArray *keys = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [name substringFromIndex:1];
        [keys addObject:key];
    }
    return keys;
}

- (id)valueOfKey:(NSString *)key {
    SEL value = NSSelectorFromString(key);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self performSelector:value];
#pragma clang diagnostic pop
}

- (id)objectCopy {
    NSArray *keys = [[self class] properties];
    id class = [[[self class] alloc] init];
    for (NSString *key in keys) {
        [class setValue:[self valueOfKey:key] forKey:key];
    }
    return class;
}

+ (BOOL)searchClass:(Class)aClass hasProperty:(NSString *)property {
    if (aClass == nil) return NO;
    if (property == nil || property.length == 0) return NO;
    
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList(aClass , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property_t = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property_t) encoding:NSUTF8StringEncoding];
        if ([key isEqualToString:property]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

- (id)assignValues:(NSDictionary *)valuesParams {
    if (valuesParams.allKeys.count == 0) return self;
    for (NSString *key in valuesParams.allKeys) {
        if ([[self class] searchClass:[self class] hasProperty:key]) {
            [self setValue:valuesParams[key] forKey:key];
        }
    }
    return self;
}

+ (id)initWithClassName:(NSString *)aClass params:(NSDictionary *)params {
    if (aClass == nil || aClass.length == 0) return nil;
    
    const char *class = [aClass cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(class);
    if (!newClass) {
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, class, 0);
        objc_registerClassPair(newClass);
    }
    id instance = [[newClass alloc] init];
    return [instance assignValues:params];
}

+ (void)makePhoneCall:(NSString *)phoneNumber {
    if (!phoneNumber || phoneNumber.length == 0) {
        return;
    }
    NSString *URLString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
    NSURL *aURL = [NSURL URLWithString:URLString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:aURL options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:aURL];
    }
}

+ (void)openURL:(NSString *)URL {
    if (!URL) {
        return;
    }
    if (URL && ![URL hasPrefix:@"https://"]) {
        if (![URL hasPrefix:@"http://"]) {
            URL = [NSString stringWithFormat:@"http://%@", URL];
        }
    }
    NSURL *aURL = [NSURL URLWithString:URL];
    if ([[UIApplication sharedApplication] canOpenURL:aURL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:aURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:aURL];
        }
    }
}

+ (void)openSystemURL:(NSString *)URL {
    NSURL *aURL = [NSURL URLWithString:URL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:aURL options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:aURL];
    }
}

+ (NSString *)device_type {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    //------------------------------iPhone---------------------------
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"] ||
        [platform isEqualToString:@"iPhone3,2"] ||
        [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"] ||
        [platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"] ||
        [platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"] ||
        [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] ||
        [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    
    //------------------------------iPad--------------------------
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"] ||
        [platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"] ||
        [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"] ||
        [platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([platform isEqualToString:@"iPad6,7"] ||
        [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    //------------------------------iPad Mini-----------------------
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"] ||
        [platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"] ||
        [platform isEqualToString:@"iPad4,8"] ||
        [platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"] ||
        [platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    //------------------------------iTouch------------------------
    if ([platform isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iTouch6";
    
    //------------------------------Samulitor-------------------------------------
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return @"Unknown";
}

+ (NSString *)shortVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)bundleIdentifier {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

@end
