//
//  YYBGesOverlayTableViewController.h
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBRefreshTableViewController.h"
#import "YYBGesOverlayTransition.h"
#import "NSBundle+YYBAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBGesOverlayTableViewController : YYBRefreshTableViewController

@property (nonatomic,strong) YYBGesOverlayTransition *transition;

- (CGFloat)contentRadius;

@end

NS_ASSUME_NONNULL_END
