//
//  YYBPhotoBrowserPushAnimator.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowserPushAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) CGRect fromImageRect;
@property (nonatomic,strong) id imageResource;

@end

NS_ASSUME_NONNULL_END
