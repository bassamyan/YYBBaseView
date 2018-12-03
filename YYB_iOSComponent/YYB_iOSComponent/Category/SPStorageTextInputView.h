//
//  SPStorageTextInputView.h
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPStorageTextInputView : UIView

@property (nonatomic,copy) void (^ textValueChangeHandler)(NSString *text);
@property (nonatomic,copy) void (^ actionButtonHandler)(void);

@property (nonatomic,strong) UITextField *textInputView;
@property (nonatomic,strong) UIButton *actionButton;

@end

NS_ASSUME_NONNULL_END
