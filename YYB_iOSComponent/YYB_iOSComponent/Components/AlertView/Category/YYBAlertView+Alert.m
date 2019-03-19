//
//  YYBAlertView+Alert.m
//  SavingPot365
//
//  Created by Aokura on 2018/9/23.
//  Copyright © 2018年 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView+Alert.h"

@implementation YYBAlertView (Alert)

+ (void)showAlertViewWithTitle:(NSString *)title
                        detail:(NSString *)detail
             cancelActionTitle:(NSString *)cancelActionTitle
            confirmActionTitle:(NSString *)confirmActionTitle
          confirmActionHandler:(YYBAlertViewActionBlankHandler)confirmActionHandler
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenterShrink;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.contentView.backgroundColor = [UIColor whiteColor];
        [container.contentView cornerRadius:16.0f];
        container.maximalWidth = 300.0f;
        container.maximalHeight = MAXFLOAT;
        container.actionsContainer.flexPosition = YYBAlertViewFlexPositionStretch;
        container.actionsContainer.flexDirection = YYBAlertViewFlexDirectionHorizonal;
        container.actionsContainer.backgroundColor = [UIColor colorWithHexInteger:0xF6F6F6];
        
        if (title)
        {
            [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
                action.margin = UIEdgeInsetsMake(20.0f, 0, 0, 0);
                label.text = title;
                label.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightSemibold];
                label.textColor = [UIColor blackColor];
            }];
        }
        
        if (detail)
        {
            [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
                action.margin = UIEdgeInsetsMake(title ? 15.0f : 20.0f, 25.0f, 20.0f, 25.0f);
                label.font = [UIFont systemFontOfSize:17.0f];
                label.textColor = [UIColor colorWithHexInteger:0x333333];
                label.numberOfLines = 0;
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.lineSpacing = 3.0f;
                paragraphStyle.alignment = NSTextAlignmentCenter;
                
                NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:detail];
                [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detail.length)];
                label.attributedText = attributed;
            }];
        }
        
        [container addCustomView:nil configureHandler:^(YYBAlertViewAction *action, UIView *view) {
            action.margin = UIEdgeInsetsMake(0, 0.0f, 0, 0.0f);
            action.size = CGSizeMake(0, 1.0f);
            view.backgroundColor = [UIColor colorWithHexInteger:0xECF0F3];
        }];
        
        if (cancelActionTitle)
        {
            [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
                action.margin = UIEdgeInsetsMake(0.5f, 0.0f, 0, confirmActionTitle ? 0.25f : 0.0f);
                action.size = CGSizeMake(0, 50.0f);
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitle:cancelActionTitle forState:0];
                [button setTitleColor:[UIColor colorWithHexInteger:0x494949 alpha:0.4f] forState:0];
                [button setTitleColor:[[UIColor colorWithHexInteger:0x494949 alpha:0.4f] colorWithAlphaComponent:0.4f] forState:1<<0];
                button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            } tapedOnHandler:nil];
        }
        
        if (confirmActionTitle)
        {
            [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
                action.margin = UIEdgeInsetsMake(0.5f, cancelActionTitle ? 0.25f : 0.0f, 0, 0.0f);
                action.size = CGSizeMake(0, 50.0f);
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitle:confirmActionTitle forState:0];
                [button setTitleColor:[UIColor colorWithHexInteger:0x1085E7 alpha:1.0f] forState:0];
                [button setTitleColor:[UIColor colorWithHexInteger:0x1085E7 alpha:0.4f] forState:1<<0];
                button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            } tapedOnHandler:^(NSInteger index) {
                if (confirmActionHandler) {
                    confirmActionHandler();
                }
            }];
        }
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

+ (void)showAlertViewWithTitle:(NSString *)title icon:(NSString *)icon confirmActionHandler:(YYBAlertViewActionBlankHandler)confirmActionHandler
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenterShrink;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.contentView.backgroundColor = [UIColor whiteColor];
        [container.contentView cornerRadius:15.0f];
        container.maximalWidth = 300.0f;
        container.maximalHeight = MAXFLOAT;
        container.actionsContainer.flexPosition = YYBAlertViewFlexPositionStretch;
        container.actionsContainer.flexDirection = YYBAlertViewFlexDirectionHorizonal;
        container.actionsContainer.backgroundColor = [UIColor colorWithHexInteger:0xEBEBEB];
        
        [container addIconViewWithHandler:^(YYBAlertViewAction *action, UIImageView *imageView) {
            action.size = CGSizeMake(0, 75.0f);
            action.margin = UIEdgeInsetsMake(12.5f, 0, 0, 0);
            
            imageView.image = [UIImage imageNamed:icon];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }];
        
        [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
            action.margin = UIEdgeInsetsMake(10.0f, 25.0f, 30.0f, 25.0f);
            label.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightLight];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 0;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 3.0f;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:title];
            [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];
            label.attributedText = attributed;
        }];
        
        [container addCustomView:nil configureHandler:^(YYBAlertViewAction *action, UIView *view) {
            action.margin = UIEdgeInsetsMake(0, 0.0f, 0, 0.0f);
            action.size = CGSizeMake(0, 1.0f);
            view.backgroundColor = [UIColor colorWithHexInteger:0xECF0F3];
        }];
        
        [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
            action.margin = UIEdgeInsetsMake(0.5f, 0.0f, 0, 0.25f);
            action.size = CGSizeMake(0, 50.0f);
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:@"取消" forState:0];
            [button setTitleColor:[UIColor colorWithHexInteger:0x494949 alpha:0.4f] forState:0];
            [button setTitleColor:[[UIColor colorWithHexInteger:0x494949 alpha:0.4f] colorWithAlphaComponent:0.4f] forState:1<<0];
            button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        } tapedOnHandler:nil];
        
        [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
            action.margin = UIEdgeInsetsMake(0.5f, 0.25f, 0, 0.0f);
            action.size = CGSizeMake(0, 50.0f);
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:@"确定" forState:0];
            [button setTitleColor:[UIColor colorWithHexInteger:0x1085E7 alpha:1.0f] forState:0];
            [button setTitleColor:[UIColor colorWithHexInteger:0x1085E7 alpha:0.4f] forState:1<<0];
            button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        } tapedOnHandler:^(NSInteger index) {
            if (confirmActionHandler) {
                confirmActionHandler();
            }
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
