//
//  YYBPhotoBrowserTransition.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBPhotoBrowserPopAnimator.h"
#import "YYBPhotoBrowserPushAnimator.h"
#import "YYBPhotoBrowserInteractiveTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowserTransition : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong,nullable) UIPanGestureRecognizer *pan;

@property (nonatomic) CGRect fromImageRect;
@property (nonatomic,strong) id imageResource;

@property (nonatomic) CGRect finishImageRect;

@end

NS_ASSUME_NONNULL_END
