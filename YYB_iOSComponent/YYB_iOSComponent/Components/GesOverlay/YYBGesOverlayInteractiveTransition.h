//
//  YYBGesOverlayInteractiveTransition.h
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBGesOverlayInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,strong,nullable) UIPanGestureRecognizer *pan;

@end

NS_ASSUME_NONNULL_END
