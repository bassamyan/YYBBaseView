//
//  YYBAlertView+DatePicker.h
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "YYBAlertDateView.h"
#import "UIColor+YYBAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (DatePicker)

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate *date))dateSelectedHandler;
+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate *date))dateSelectedHandler mode:(UIDatePickerMode)mode date:(NSDate *)date;

+ (void)showAlertViewWithMinimalDate:(NSDate *)minimalDate initDate:(NSDate *)initDate selectedHandler:(void (^)(NSDate *date))dateSelectedHandler;

@end

NS_ASSUME_NONNULL_END
