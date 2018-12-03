//
//  NSDateYYBAdd.m
//  Framework
//
//  Created by Aokura on 2018/2/14.
//  Copyright © 2018年 Tree, Inc. All rights reserved.
//

#import "NSDate+YYBAdd.h"

@implementation NSDate (YYBAdd)

static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
/**
 相关ISO8601规则详见 http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 */
static NSString * const kISO8601DateFormatter = @"EEE, d MMM yyyy HH:mm:ss Z";
static NSString * const kDefaultDateFormatter = @"YYYY-MM-dd";

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:componentFlags fromDate:self];
}

- (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit withOffset:(NSInteger)offset {
    NSDateComponents *compo = [[NSDateComponents alloc] init];
    [compo setValue:offset forComponent:unit];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:compo toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    return [self dateByAddingUnit:NSCalendarUnitDay withOffset:days];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
    return [self dateByAddingUnit:NSCalendarUnitMonth withOffset:months];
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
    return [self dateByAddingUnit:NSCalendarUnitYear withOffset:years];
}

+ (NSDate *)yesterday {
    return [[NSDate date] dateByAddingUnit:NSCalendarUnitDay withOffset:-1];
}

+ (NSDate *)tomorrow {
    return [[NSDate date] dateByAddingUnit:NSCalendarUnitDay withOffset:1];
}

- (NSString *)weekend {
    NSDictionary *dict = @{@"Mon" : @"周一",
                           @"Tue" : @"周二",
                           @"Wed" : @"周三",
                           @"Thu" : @"周四",
                           @"Fri" : @"周五",
                           @"Sat" : @"周六",
                           @"Sun" : @"周日"};
    
    NSString *weekText = [self toStringWithFormatter:@"EEE"];
    
    if ([dict.allValues containsObject:weekText]) {
        return weekText;
    }
    
    if ([dict.allKeys containsObject:weekText]) {
        return [dict objectForKey:weekText];
    }
    return nil;
}

- (NSString *)toStringWithFormatter:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toStringWithFormatterType:(dateFormatType)type {
    NSArray *types = @[@"HH:mm",
                       @"MM-dd",
                       @"YYYY-MM-dd",
                       @"YYYY-MM-dd HH:mm"];
    if (types.count > type) {
        return [self toStringWithFormatter:types[type]];
    }
    return nil;
}

+ (NSDate *)dateFromDateString:(NSString *)dateString withFormatter:(NSString *)format {
    NSDateFormatter *dFormat = [[NSDateFormatter alloc] init];
    dFormat.dateFormat = format ? : kDefaultDateFormatter;
    dFormat.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    return [dFormat dateFromString:dateString];
}

+ (BOOL)isDate:(NSDate *)aDate withDate:(NSDate *)bDate equalWithUnits:(unsigned int)units {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:units fromDate:aDate];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:units fromDate:bDate];
    
    NSArray *flags = @[@(NSCalendarUnitDay),@(NSCalendarUnitMonth),@(NSCalendarUnitYear)];
    for (int i = 0; i < flags.count; i++) {
        unsigned int flag = [flags[i] intValue];
        if ((units & flag) == flag) {
            if ([components1 valueForComponent:flag] != [components2 valueForComponent:flag]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)isYMDEqualToDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isYEqualToDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isDateToday {
    return [self isYMDEqualToDate:[NSDate date]];
}

- (BOOL)isDateTomorrow {
    return [self isYMDEqualToDate:[NSDate tomorrow]];
}

- (BOOL)isDateYesterday {
    return [self isYMDEqualToDate:[NSDate yesterday]];
}

- (NSDate *)endOfDay {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate: self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [cal dateFromComponents:components];
}

- (NSDate *)startOfDay {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate: self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [cal dateFromComponents:components];
}

- (NSDate *)startDayOfMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate: self];
    components.day = 1;
    return [cal dateFromComponents:components];
}

- (NSDate *)endDayOfMonth {
    return [[[self startDayOfMonth] dateByAddingDays:[self daysOfMonth] - 1] endOfDay];
}

- (NSInteger)daysOfMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange days = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return days.length;
}

+ (NSDate *)todayAtMidnight {
    return [[NSDate date] endOfDay];
}

+ (NSDate *)todayAtStart {
    return [[NSDate date] startOfDay];
}

+ (NSInteger)compareDaysWithDate:(NSDate *)date toOtherDate:(NSDate *)otherDate {
    return [self differenceWithUnit:NSCalendarUnitDay date:date toOtherDate:otherDate].day;
}

+ (NSDateComponents *)differenceWithUnit:(NSCalendarUnit)unit date:(NSDate *)date toOtherDate:(NSDate *)otherDate {
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:unit startDate:&fromDate
                 interval:NULL forDate:date];
    [calendar rangeOfUnit:unit startDate:&toDate
                 interval:NULL forDate:otherDate];
    
    NSDateComponents *difference = [calendar components:unit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return difference;
}

@end
