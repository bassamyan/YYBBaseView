//
//  YYBAlertDateView.m
//  SavingPot365
//
//  Created by September on 2018/11/1.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertDateView.h"

@interface YYBAlertDateView ()
@property (nonatomic,strong) UIButton *cancelButton, *submitButton;
@property (nonatomic,strong) UIView *segmentView;

@end

@implementation YYBAlertDateView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    @weakify(self);
    _cancelButton = [UIButton buttonWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.height.mas_equalTo(45.0f);
        make.top.equalTo(self);
        make.width.mas_equalTo(100.0f);
    } configureButtonHandler:^(UIButton *button) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor colorWithHexInteger:0xBABABA] forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button setTitle:@"取消" forState:0];
    } tapedHandler:^(UIButton *sender) {
        @strongify(self);
        if (self.cancelActionHandler) {
            self.cancelActionHandler();
        }
    }];
    
    _submitButton = [UIButton buttonWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(45.0f);
        make.top.equalTo(self);
        make.width.mas_equalTo(100.0f);
    } configureButtonHandler:^(UIButton *button) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleColor:[UIColor colorWithHexInteger:0x69B2FD] forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button setTitle:@"确定" forState:0];
    } tapedHandler:^(UIButton *sender) {
        @strongify(self);
        if (self.submitActionHandler) {
            self.submitActionHandler(self.datePicker.date);
        }
    }];
    
    _segmentView = [UIView viewWithColor:[UIColor colorWithHexInteger:0xEBEBEB] superView:self constraint:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.cancelButton.mas_bottom);
        make.height.mas_equalTo(0.5f);
    } configureHandler:nil];
    
    _datePicker = [UIDatePicker viewWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.mas_bottom);
    } configureHandler:^(UIDatePicker *view) {
        view.datePickerMode = UIDatePickerModeTime;
    }];
    
    return self;
}

@end
