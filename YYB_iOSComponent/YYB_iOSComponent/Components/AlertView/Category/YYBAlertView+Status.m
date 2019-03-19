//
//  YYBAlertView+Status.m
//  SavingPot365
//
//  Created by Aokura on 2018/9/21.
//  Copyright © 2018年 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView+Status.h"

@implementation YYBAlertView (Status)

+ (void)showAlertViewWithStatus:(NSString *)status
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenterShrink;
    alertView.autoHideTimeInterval = 2.0f;
    alertView.isConstraintedWithContainer = TRUE;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.contentView.backgroundColor = [UIColor blackColor];
        container.contentView.layer.shadowColor = [UIColor colorWithHexInteger:0xAFADAD alpha:0.5f].CGColor;
        container.contentView.layer.shadowOffset = CGSizeZero;
        container.contentView.layer.shadowRadius = 14.0f;
        [container.contentView cornerRadius:4.0f];
        
        [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
            action.margin = UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f);

            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
            label.numberOfLines = 0;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 3.0f;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSString *text = [status isExist] ? status : @"出错了";
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
            [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
            label.attributedText = attributed;
        }];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView showAlertViewOnKeyWindow];
    });
}

+ (void)showSuccessStatusViewWithText:(NSString *)text duration:(NSTimeInterval)duration
{
    [self showStatusViewWithText:text icon:@"ic_status_success" duration:duration];
}

+ (void)showErrorStatusViewWithText:(NSString *)text duration:(NSTimeInterval)duration
{
    [self showStatusViewWithText:text icon:@"ic_status_error" duration:duration];
}

+ (void)showStatusViewWithText:(NSString *)text icon:(NSString *)icon duration:(NSTimeInterval)duration
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.isCloseAlertViewWhenTapedBackgroundView = FALSE;
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenter;
    alertView.isConstraintedWithContainer = TRUE;
    alertView.autoHideTimeInterval = duration;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.flexDirection = YYBAlertViewFlexDirectionHorizonal;
        container.contentView.backgroundColor = [UIColor blackColor];
        [container.contentView cornerRadius:8.0f];

        [container addIconViewWithHandler:^(YYBAlertViewAction *action, UIImageView *imageView) {
            action.size = CGSizeMake(25.0f, 25.0f);
            action.margin = UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 10.0f);
            
            imageView.image = [NSBundle imageWithBundleName:@"Icon_AlertView" imageName:icon];
        }];
        
        [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
            action.margin = UIEdgeInsetsMake(0, 0, 0, 20.0f);
            
            label.text = text;
            label.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
            label.textColor = [UIColor whiteColor];
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
