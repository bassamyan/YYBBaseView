//
//  YYBPhotoBrowserInteractiveTransition.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoBrowserInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,strong) UIPanGestureRecognizer *pan;

@property (nonatomic) CGRect fromImageRect; // 初始图片尺寸
@property (nonatomic,strong) id imageURL;

@property (nonatomic) CGRect finishImageRect; // 放大后的图片尺寸

@end

NS_ASSUME_NONNULL_END
