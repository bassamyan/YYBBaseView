//
//  YYBAlertView+Status.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/21.
//  Copyright © 2018年 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView.h"
#import "UIColor+YYBAdd.h"
#import "NSBundle+YYBAdd.h"
#import "NSString+YYBAdd.h"
#import "UIView+YYBAdd.h"

@interface YYBAlertView (Status)

+ (void)showAlertViewWithStatus:(NSString *)status;

+ (void)showSuccessStatusViewWithText:(NSString *)text duration:(NSTimeInterval)duration;
+ (void)showErrorStatusViewWithText:(NSString *)text duration:(NSTimeInterval)duration;

@end
