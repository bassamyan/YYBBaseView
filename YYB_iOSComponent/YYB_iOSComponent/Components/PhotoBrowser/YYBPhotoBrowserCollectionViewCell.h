//
//  YYBPhotoBrowserCollectionViewCell.h
//  SavingPot365
//
//  Created by September on 2018/10/27.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowserCollectionViewCell : UICollectionViewCell

- (void)renderItemWithImage:(nullable UIImage *)image imageURL:(nullable NSString *)imageURL;
@property (nonatomic,copy) void (^ oneTapedHandler)(void);

@end

NS_ASSUME_NONNULL_END
