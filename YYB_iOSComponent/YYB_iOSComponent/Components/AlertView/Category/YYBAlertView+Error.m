//
//  YYBAlertView+Error.m
//  SavingPot365
//
//  Created by September on 2018/10/26.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView+Error.h"

@implementation YYBAlertView (Error)

+ (void)showAlertViewWithError:(NSError *)error
{
    NSString *description = error.localizedDescription;
    NSString *message = [error.userInfo objectForKey:@"message"];
    
    if ([message isExist]) {
        [YYBAlertView showAlertViewWithStatus:message];
    } else if ([description isExist]) {
        [YYBAlertView showAlertViewWithStatus:description];
    } else {
        [YYBAlertView showAlertViewWithStatus:@"请求出错"];
    }
}

@end
