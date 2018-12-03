//
//  YYBAlertView+Storage.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertView (Storage)

+ (void)showStorageAlertViewWithMoney:(CGFloat)money
                       prestoredMoney:(CGFloat)prestoredMoney
                                 desc:(NSString *)desc
                               cardId:(NSInteger)cardId
              descValueChangedHandler:(void(^)(NSString *string))descValueChangedHandler
                   cardChangedHandler:(void (^)(NSInteger cardId))cardChangedHandler
                  storageTapedHandler:(void(^)(CGFloat neededPrestoredMoney, CGFloat neededMoney))storageTapedHandler;

@end

NS_ASSUME_NONNULL_END
