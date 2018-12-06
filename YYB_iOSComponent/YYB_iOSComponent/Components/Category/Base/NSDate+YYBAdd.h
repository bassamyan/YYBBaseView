//
//  NSDate+YYBAdd.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,YYBDateFormatType) {
    YYBDateFormatTypeHm    = 0,
    YYBDateFormatTypeMD    = 1,
    YYBDateFormatTypeYMD   = 2,
    YYBDateFormatTypeYMDHm = 3,
};

@interface NSDate (YYBAdd)

// 获取时间的某个部分
- (NSDateComponents *)components;

// 获取星期几
- (NSString *)weekend;

// 根据值获取对应的间隔时间
- (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit withOffset:(NSInteger)offset;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingYears:(NSInteger)years;

// 根据类型获得对应的时间文本
- (NSString *)toStringWithFormatterType:(YYBDateFormatType)type;
- (NSString *)toStringWithFormatter:(NSString *)format;

// 根据时间文本获取时间
+ (NSDate *)dateFromDateString:(NSString *)dateString withFormatter:(NSString *)format;

+ (NSDate *)yesterday;
+ (NSDate *)tomorrow;

- (BOOL)isDateToday;
- (BOOL)isDateTomorrow;
- (BOOL)isDateYesterday;

// 是否这个两个时间的对应部分相同
+ (BOOL)isDate:(NSDate *)aDate withDate:(NSDate *)bDate equalWithUnits:(unsigned)units;

/**
 当前时间是否与对应时间相同
 @brief 有且只比较年、月、日
 */
- (BOOL)isYMDEqualToDate:(NSDate *)aDate;
- (BOOL)isYEqualToDate:(NSDate *)aDate;

// 获取这天的第一秒的时间
- (NSDate *)startOfDay;

// 获取这天的最后一秒的时间
- (NSDate *)endOfDay;

// 获取这个月的第一天的第一秒的时间
- (NSDate *)startDayOfMonth;

// 获取这个月的最后一天的最后一秒的时间
- (NSDate *)endDayOfMonth;

// 获取这个月总共有几天
- (NSInteger)daysOfMonth;

+ (NSDate *)todayAtMidnight;
+ (NSDate *)todayAtStart;

// 比较两个时间的天数差值
+ (NSInteger)compareDaysWithDate:(NSDate *)date toOtherDate:(NSDate *)otherDate;
+ (NSDateComponents *)differenceWithUnit:(NSCalendarUnit)unit date:(NSDate *)date toOtherDate:(NSDate *)otherDate;

@end
