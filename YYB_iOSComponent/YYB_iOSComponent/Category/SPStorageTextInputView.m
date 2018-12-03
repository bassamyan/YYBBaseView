//
//  SPStorageTextInputView.m
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "SPStorageTextInputView.h"

@interface SPStorageTextInputView ()
@property (nonatomic,strong) UIView *segmentView;

@end

@implementation SPStorageTextInputView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _textInputView = [UITextField textFieldSuperView:self constraint:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self).offset(25.0f);
        make.right.equalTo(self).offset(-75.0f);
    } configureHandler:^(UITextField *textField) {
        textField.placeholder = @"输入存储摘要 ...";
        [textField setValue:[UIColor colorWithHexInteger:0xCECECE] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:18.0f] forKeyPath:@"_placeholderLabel.font"];
        textField.font = [UIFont systemFontOfSize:18.0f];
    }];
    
    @weakify(self);
    [_textInputView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (self.textValueChangeHandler) {
            self.textValueChangeHandler(x);
        }
    }];
    
    _actionButton = [UIButton buttonWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25.0f);
        make.centerY.equalTo(self.textInputView);
        make.size.mas_equalTo(CGSizeMake(35.0f, 25.0f));
    } configureButtonHandler:^(UIButton *button) {
        [button setTitleColor:[UIColor colorWithHexInteger:0x1085E7] forState:0];
        [button setTitle:@"完成" forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
        button.hidden = TRUE;
    } tapedHandler:^(UIButton *sender) {
        @strongify(self);
        if (self.actionButtonHandler) {
            self.actionButtonHandler();
        }
    }];
    
    _segmentView = [UIView viewWithColor:[UIColor colorWithHexInteger:0xEDEDED] superView:self constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25.0f);
        make.right.equalTo(self).offset(-25.0f);
        make.top.equalTo(self.textInputView.mas_bottom);
        make.height.mas_equalTo(0.5f);
    } configureHandler:nil];
    
    return self;
}

@end
