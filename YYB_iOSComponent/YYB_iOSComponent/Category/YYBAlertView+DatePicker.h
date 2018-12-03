//
//  YYBAlertView+DatePicker.h
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (DatePicker)

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate *date))dateSelectedHandler;
+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate *date))dateSelectedHandler mode:(UIDatePickerMode)mode date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
