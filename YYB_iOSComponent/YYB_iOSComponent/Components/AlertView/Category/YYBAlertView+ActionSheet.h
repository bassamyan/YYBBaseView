//
//  YYBAlertView+ActionSheet.h
//  SavingPot365
//
//  Created by September on 2018/10/14.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView.h"
#import "UIColor+YYBAdd.h"
#import "UIDevice+YYBAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (ActionSheet)

+ (void)showAlertActionSheetWithActions:(NSArray *)actions actionTapedHandler:(YYBAlertViewActionHandler)actionTapedHandler;

@end

NS_ASSUME_NONNULL_END
