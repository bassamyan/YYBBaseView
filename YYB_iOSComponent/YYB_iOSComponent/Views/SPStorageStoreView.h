//
//  SPStorageStoreView.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPStorageStoreView : UIView

- (void)renderItemWithDesc:(NSString *)desc cardId:(NSInteger)cardId storeMoney:(CGFloat)storeMoney prestoredMoney:(CGFloat)prestoredMoney;

@property (nonatomic,copy) void (^ descValueChangeHandler)(NSString *desc);

@property (nonatomic,copy) void (^ showCardSettingPageHandler)(void);
@property (nonatomic,copy) void (^ storageTapedHandler)(CGFloat neededPrestoredMoney, CGFloat neededMoney);
@property (nonatomic,copy) void (^ cardChangedHandler)(NSInteger bankId);
@property (nonatomic,copy) void (^ resignKeyboardResponderHandler)(void);

@end

NS_ASSUME_NONNULL_END
