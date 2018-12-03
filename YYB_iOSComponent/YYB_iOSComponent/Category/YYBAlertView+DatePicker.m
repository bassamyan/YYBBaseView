//
//  YYBAlertView+DatePicker.m
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBAlertView+DatePicker.h"
#import "SPCreateDateView.h"

@implementation YYBAlertView (DatePicker)

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate * _Nonnull))dateSelectedHandler
{
    [self showAlertViewWithDatePickerSelectedHandler:dateSelectedHandler mode:UIDatePickerModeTime date:[NSDate date]];
}

+ (void)showAlertViewWithDatePickerSelectedHandler:(void (^)(NSDate * _Nonnull))dateSelectedHandler mode:(UIDatePickerMode)mode date:(NSDate *)date
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    
    alertView.createRectHandler = ^CGRect(NSInteger index, YYBAlertViewContainer *container) {
        CGSize contentSize = container.contentSizeWithActions;
        return CGRectMake(0, kScreenHeight - contentSize.height, contentSize.width, contentSize.height);
    };
    
    @weakify(alertView);
    alertView.showContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container) {
        @strongify(alertView);
        
        container.transform = CGAffineTransformMakeTranslation(0, container.contentSizeWithActions.height);
        alertView.backgroundView.alpha = 0.0f;
        
        [UIView animateWithDuration:0.2f animations:^{
            container.transform = CGAffineTransformIdentity;
            alertView.backgroundView.alpha = 1.0f;
        }];
        
        return TRUE;
    };
    
    alertView.closeContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container, void (^removeSubviewsHandler)(void)) {
        @strongify(alertView);
        
        alertView.backgroundView.alpha = 1.0f;
        [UIView animateWithDuration:0.2f animations:^{
            container.transform = CGAffineTransformMakeTranslation(0, container.contentSizeWithActions.height);
            alertView.backgroundView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            removeSubviewsHandler();
        }];
        
        return TRUE;
    };
                          
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        @strongify(alertView);
            
        container.maximalWidth = kScreenWidth;
        container.backgroundColor = [UIColor whiteColor];
        
        SPCreateDateView *view = [[SPCreateDateView alloc] init];
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
            action.size = CGSizeMake(kScreenWidth, 260.0f);
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
