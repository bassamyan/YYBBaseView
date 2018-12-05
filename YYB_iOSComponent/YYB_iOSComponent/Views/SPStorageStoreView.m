//
//  SPStorageStoreView.m
//  SavingPot365
//
//  Created by Sniper on 2018/11/30.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "SPStorageStoreView.h"
#import "SPStorageTextInputView.h"
#import "SPStorageCardsView.h"

@interface SPStorageStoreView () 
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) SPStorageCardsView *cardsView;
@property (nonatomic,strong) SPStorageTextInputView *summaryTextView;
@property (nonatomic,strong) UIButton *actionButton;

@property (nonatomic) CGFloat prestoredMoney, storeMoney;

@end

@implementation SPStorageStoreView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self cornerRadius:20.0f];
    
    _moneyLabel = [UILabel labelWithText:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17.0f] superView:self constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25.0f);
        make.top.equalTo(self).offset(17.5f);
    } configureHandler:nil];
    
    @weakify(self);
    _cardsView = [SPStorageCardsView viewWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.mas_bottom);
        make.height.mas_equalTo(130.0f);
        make.left.width.equalTo(self);
    } configureHandler:^(SPStorageCardsView *view) {
        @strongify(self);
        view.storageCardSelectedHandler = ^(NSInteger cardId) {
            if (cardId == 0) {
                [self.actionButton setTitle:@"完成 (不选择存储卡片)" forState:0];
            } else {
                [self.actionButton setTitle:@"完成" forState:0];
            }
            if (self.cardChangedHandler) {
                self.cardChangedHandler(cardId);
            }
        };
        view.showCardSettingPageHandler = ^{
            if (self.showCardSettingPageHandler) {
                self.showCardSettingPageHandler();
            }
        };
    }];
    
    _summaryTextView = [SPStorageTextInputView viewWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardsView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(54.0f);
    } configureHandler:^(SPStorageTextInputView *view) {
        @strongify(self);
        view.textValueChangeHandler = ^(NSString * _Nonnull text) {
            if (self.descValueChangeHandler) {
                self.descValueChangeHandler(text);
            }
        };
        view.actionButtonHandler = ^{
            if (self.resignKeyboardResponderHandler) {
                self.resignKeyboardResponderHandler();
            }
        };
    }];
    
    _actionButton = [UIButton buttonWithSuperView:self constraint:^(MASConstraintMaker *make) {
        make.top.equalTo(self.summaryTextView.mas_bottom).offset(20.0f);
        make.left.equalTo(self).offset(25.0f);
        make.right.equalTo(self).offset(-25.0f);
        make.height.mas_equalTo(45.0f);
    } configureButtonHandler:^(UIButton *button) {
        [button cornerRadius:7.0f];
        [button setBackgroundImage:[UIColor colorWithHexInteger:0x1085E7].colorImage forState:0];
        [button setTitle:@"完成" forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
    } tapedHandler:^(UIButton *sender) {
        @strongify(self);
        if (self.storageTapedHandler) {
            self.storageTapedHandler(self.prestoredMoney,self.storeMoney);
        }
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
     subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
         self.summaryTextView.actionButton.hidden = TRUE;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
     subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
         self.summaryTextView.actionButton.hidden = FALSE;
     }];
    
    return self;
}

- (void)renderItemWithDesc:(NSString *)desc cardId:(NSInteger)cardId storeMoney:(CGFloat)storeMoney prestoredMoney:(CGFloat)prestoredMoney {
    
    _summaryTextView.textInputView.text = desc;
    
    [_cardsView renderStorageInitialCard:cardId];
    if (cardId == 0) {
        [_actionButton setTitle:@"完成 (不选择存储卡片)" forState:0];
    }
    
    CGFloat prestore_use_money = prestoredMoney > storeMoney ? storeMoney : prestoredMoney;
    NSString *prestore_use_money_text = [NSString stringWithFormat:@" %.2f ",prestore_use_money];
    
    CGFloat money_need_save = storeMoney - prestore_use_money;
    NSString *money_need_save_text = [NSString stringWithFormat:@" %.2f ",money_need_save];
    
    self.prestoredMoney = prestore_use_money;
    self.storeMoney = money_need_save;
    
    NSString *storageMoneyText = [NSString stringWithFormat:@"还需存储%@ 使用预存款%@",money_need_save_text,prestore_use_money_text];
    
    NSMutableAttributedString *storage_attributed = [[NSMutableAttributedString alloc] initWithString:storageMoneyText];
    [storage_attributed addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexInteger:0x1085E7] range:NSMakeRange(4, money_need_save_text.length)];
    [storage_attributed addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexInteger:0x1085E7] range:NSMakeRange(10 + money_need_save_text.length, prestore_use_money_text.length)];
    
    self.moneyLabel.attributedText = storage_attributed;
}

@end
