//
//  NSString+YYBAdd.h
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YYBAdd)

- (BOOL)isExist;

// 这里注意nil/null是走不了这个方法的,判断字符串是否存在最好用isExist方法
- (BOOL)isEmpty;
- (BOOL)isEmail;

// 手机号是否正确
- (BOOL)isValidPhone;

// 是否都是数字
- (BOOL)isAllNumber;

// 是否都是中文
- (BOOL)isAllChinese;

// 是否都是英文单词
- (BOOL)isAllEnglish;

// 是否包含中文
- (BOOL)isContainsChinese;

// 是否包含emoji表情
- (BOOL)isContainsEmoji;

// 是否是合格的身份证号码
- (BOOL)isValidIdCard;

// 邮箱验证
- (BOOL)isValidEmail;

// 是否是正确的账号注册字符
// 包含数字字符+@._
- (BOOL)isValidUsername;

// 删除空格
- (NSString *)trimWhitespace;

// 删除空格和换行
- (NSString *)trimWhiteSpaceAndEmptyLine;

// 是否有空格
- (BOOL)isContainsWhiteSpace;

// 获取一个随机的字符
+ (NSString *)stringRandomly;

// 转换拼音
- (NSString *)transformToPinyin;

/**
 对后台传过来的URL进行处理
 去除空格、中文编码
 */
- (NSURL *)handleURL;

- (NSString *)md5;
- (NSString *)sha256;
- (NSString *)hmacsha256:(NSString *)key;
- (NSString *)urlEncoding;

@end
