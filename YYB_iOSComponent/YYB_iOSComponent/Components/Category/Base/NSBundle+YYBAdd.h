//
//  NSBundle+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/8.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (YYBAdd)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
