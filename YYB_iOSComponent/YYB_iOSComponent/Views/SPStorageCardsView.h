//
//  SPStorageCardsView.h
//  SavingPot365
//
//  Created by Sniper on 2018/12/1.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPStorageCardsView : UIView

@property (nonatomic,copy) void (^ showCardSettingPageHandler)(void);
@property (nonatomic,copy) void (^ storageCardSelectedHandler)(NSInteger cardId);

- (void)renderStorageInitialCard:(NSInteger)cardId;

@end

NS_ASSUME_NONNULL_END
