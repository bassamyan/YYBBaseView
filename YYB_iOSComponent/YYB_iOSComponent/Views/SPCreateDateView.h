//
//  SPCreateDateView.h
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPCreateDateView : UIView

@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,copy) void (^ cancelActionHandler)(void);
@property (nonatomic,copy) void (^ submitActionHandler)(NSDate *date);

@end

NS_ASSUME_NONNULL_END
