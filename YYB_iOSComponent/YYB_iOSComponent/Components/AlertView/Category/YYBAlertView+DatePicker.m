//
//  YYBAlertView+DatePicker.m
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView+DatePicker.h"

@implementation YYBAlertView (DatePicker)

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate * _Nonnull))dateSelectedHandler
{
    [self showAlertViewWithDatePickerSelectedHandler:dateSelectedHandler mode:UIDatePickerModeTime date:[NSDate date]];
}

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate * _Nonnull))dateSelectedHandler mode:(UIDatePickerMode)mode date:(NSDate *)date
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleBottom;
    
    @weakify(alertView);
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        @strongify(alertView);
            
        container.maximalWidth = [UIScreen mainScreen].bounds.size.width;
        container.backgroundColor = [UIColor whiteColor];
        
        YYBAlertDateView *view = [[YYBAlertDateView alloc] init];
        view.datePicker.datePickerMode = mode;
        view.datePicker.date = date;
        
        view.submitActionHandler = ^(NSDate * _Nonnull date) {
            if (dateSelectedHandler) {
                dateSelectedHandler(date);
            }
            [alertView closeAlertView];
        };
        view.cancelActionHandler = ^{
            [alertView closeAlertView];
        };
        
        [container addCustomView:view configureHandler:^(YYBAlertViewAction *action, UIView *view) {
            action.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 260.0f);
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

+ (void)showAlertViewWithMinimalDate:(NSDate *)minimalDate initDate:(nonnull NSDate *)initDate selectedHandler:(nonnull void (^)(NSDate * _Nonnull))dateSelectedHandler
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleBottom;
    
    @weakify(alertView);
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        @strongify(alertView);
        
        container.maximalWidth = [UIScreen mainScreen].bounds.size.width;
        container.backgroundColor = [UIColor whiteColor];
        
        YYBAlertDateView *view = [[YYBAlertDateView alloc] init];
        view.datePicker.datePickerMode = UIDatePickerModeDate;
        view.datePicker.date = initDate;
        view.datePicker.minimumDate = minimalDate;
        
        view.submitActionHandler = ^(NSDate * _Nonnull date) {
            if (dateSelectedHandler) {
                dateSelectedHandler(date);
            }
            [alertView closeAlertView];
        };
        view.cancelActionHandler = ^{
            [alertView closeAlertView];
        };
        
        [container addCustomView:view configureHandler:^(YYBAlertViewAction *action, UIView *view) {
            action.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 260.0f);
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
