//
//  SPStorageCardSettingCollectionViewCell.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPStorageCardSettingCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) void (^ cardSettingActionHandler)(void);

@end

NS_ASSUME_NONNULL_END
