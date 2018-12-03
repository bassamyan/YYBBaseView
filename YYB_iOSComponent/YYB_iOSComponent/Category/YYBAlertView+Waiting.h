//
//  YYBAlertView+Waiting.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/26.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBAlertView.h"

@interface YYBAlertView (Waiting)

+ (YYBAlertView *)showWaitingAlertView;
+ (YYBAlertView *)showWaitingAlertViewWithTimeInterval:(NSTimeInterval)timeInterval;

@end
