//
//  YYBAlertView+Storage.m
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBAlertView+Storage.h"
#import "SPStorageStoreView.h"
#import "YYBAlertView+Animation.h"

@implementation YYBAlertView (Storage)

+ (void)showStorageAlertViewWithMoney:(CGFloat)money
                       prestoredMoney:(CGFloat)prestoredMoney
                                 desc:(nonnull NSString *)desc
                               cardId:(NSInteger)cardId
              descValueChangedHandler:(nonnull void (^)(NSString * _Nonnull))descValueChangedHandler
                   cardChangedHandler:(nonnull void (^)(NSInteger))cardChangedHandler
                  storageTapedHandler:(nonnull void (^)(CGFloat, CGFloat))storageTapedHandler
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.isAutoControlKeyboardNotification = FALSE;
    alertView.isUsingKeyboardNotification = TRUE;
    alertView.offsetOfContainerToKeyboard = ^CGFloat(NSInteger containerIndex) {
        return 0.0f;
    };
    [alertView addSheetStyleAnimation];
    
    @weakify(alertView);
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        @strongify(alertView);
        
        CGFloat width = kScreenWidth;
        CGFloat height = 320.0f + [UIDevice safeAreaBottom];
        
        container.minimalWidth = width;
        container.minimalHeight = height;
        
        SPStorageStoreView *storageView = [[SPStorageStoreView alloc] init];
        [storageView renderItemWithDesc:desc cardId:cardId storeMoney:money prestoredMoney:prestoredMoney];
        
        storageView.descValueChangeHandler = descValueChangedHandler;
        storageView.cardChangedHandler = cardChangedHandler;
        storageView.showCardSettingPageHandler = ^{
            [alertView closeAlertView];
        };
        storageView.storageTapedHandler = ^(CGFloat neededPrestoredMoney, CGFloat neededMoney) {
            if (storageTapedHandler) {
                storageTapedHandler(neededPrestoredMoney,neededMoney);
            }
            [alertView closeAlertView];
        };
        storageView.resignKeyboardResponderHandler = ^{
            [alertView resignKeyboardResponder];
        };
        
        [container addCustomView:storageView configureHandler:^(YYBAlertViewAction *action, UIView *view) {
            action.size = CGSizeMake(width, height);
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
