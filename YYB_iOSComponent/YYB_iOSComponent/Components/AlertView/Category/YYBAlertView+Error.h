//
//  YYBAlertView+Error.h
//  SavingPot365
//
//  Created by September on 2018/10/26.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView.h"
#import "YYBAlertView+Status.h"
#import "NSString+YYBAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (Error)

+ (void)showAlertViewWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
