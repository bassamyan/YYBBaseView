//
//  NSStringYYBAdd.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "NSString+YYBAdd.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (YYBAdd)

- (BOOL)isExist {
    return self.length != 0 && [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length != 0;
}

- (BOOL)isEmpty {
    return self.length == 0 || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
}

- (BOOL)isValidPhone {
    NSString *mobile = self;
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else{
            return NO;
        }
    }
}

- (BOOL)isContainsWhiteSpace {
    return [self rangeOfString:@" "].location != NSNotFound;
}

- (BOOL)isAllNumber {
    unichar c;
    for (int i = 0; i < self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isEmail {
    NSString *emailRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidUsername {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[a-zA-Z0-9@._]+$"];
    return [pre evaluateWithObject:self];
}

- (BOOL)isAllChinese {
    NSString *chineseRegex = @"^[\\u4E00-\\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseRegex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isContainsChinese {
    for(int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isAllEnglish {
    if (self.length == 0) return NO;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [regular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    return count == self.length;
}

- (BOOL)isContainsEmoji {
    __block BOOL returnValue = NO;
    if (self) {
        NSString *emojiString = [self copy];
        
        [emojiString enumerateSubstringsInRange:NSMakeRange(0, emojiString.length)
                                   options:NSStringEnumerationByComposedCharacterSequences
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                    const unichar hs = [substring characterAtIndex:0];
                                    if (0xd800 <= hs && hs <= 0xdbff) {
                                        if (substring.length > 1) {
                                            const unichar ls = [substring characterAtIndex:1];
                                            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                            if (0x1d000 <= uc && uc <= 0x1f77f) {
                                                returnValue = YES;
                                            }
                                        }
                                    } else if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        if (ls == 0x20e3) {
                                            returnValue = YES;
                                        }
                                    } else {
                                        if (0x2100 <= hs && hs <= 0x27ff) {
                                            returnValue = YES;
                                        } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                            returnValue = YES;
                                        } else if (0x2934 <= hs && hs <= 0x2935) {
                                            returnValue = YES;
                                        } else if (0x3297 <= hs && hs <= 0x3299) {
                                            returnValue = YES;
                                        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                            returnValue = YES;
                                        }
                                    }
                                }];
        return returnValue;
    }
    return NO;
}

- (BOOL)isValidIdCard {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)trimWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimWhiteSpaceAndEmptyLine {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)stringRandomly {
    return [NSString stringWithFormat:@"%c",arc4random_uniform(26) + 'a'];
}

+ (NSString *)hexString:(uint8_t *)bytes withLength:(NSInteger)len {
    NSMutableString *output = [NSMutableString stringWithCapacity:len * 2];
    for(int i = 0; i < len; i++) {
        [output appendFormat:@"%02x", bytes[i]];
    }
    return [output copy];
}

- (NSString *)md5 {
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (uint32_t)strlen(str), result);
    return [NSString hexString:result withLength:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha256 {
    const char *str = [self UTF8String];
    uint8_t result[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (uint32_t)strlen(str), result);
    return [NSString hexString:result withLength:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hmacsha256:(NSString *)key {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hmac = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [hmac base64EncodedStringWithOptions:0];
}

- (NSString *)stringURLEncode {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}

- (NSString *)transformToPinyin {
    if (self.length == 0) {
        return self;
    }
    
    NSString *tempString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [tempString uppercaseString];
}


- (NSURL *)handleURL {
    NSString *urlStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // decode
    NSString *originalUrlStr = [urlStr stringByRemovingPercentEncoding];
    // encode
    NSString *encodeStr = [originalUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return [NSURL URLWithString:encodeStr];
}

- (NSString *)imageURLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpace size:(CGSize)size
{
    NSMutableParagraphStyle *graph = [[NSMutableParagraphStyle alloc] init];
    graph.lineSpacing = lineSpace;
    graph.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    attr[NSParagraphStyleAttributeName] = graph;
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    return rect.size;
}

@end
