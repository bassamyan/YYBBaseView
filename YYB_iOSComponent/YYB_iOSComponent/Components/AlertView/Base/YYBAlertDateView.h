//
//  YYBAlertDateView.h
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "UIView+YYBLayout.h"
#import "UIButton+YYBLayout.h"
#import "UIColor+YYBAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBAlertDateView : UIView

@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,copy) void (^ cancelActionHandler)(void);
@property (nonatomic,copy) void (^ submitActionHandler)(NSDate *date);

@end

NS_ASSUME_NONNULL_END
