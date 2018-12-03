//
//  YYBPhotoBrowserInteractiveTransition.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowserInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,strong) UIPanGestureRecognizer *pan;

@property (nonatomic) CGRect fromImageRect;
@property (nonatomic,strong) id imageResource;

@property (nonatomic) CGRect finishImageRect;

@end

NS_ASSUME_NONNULL_END
