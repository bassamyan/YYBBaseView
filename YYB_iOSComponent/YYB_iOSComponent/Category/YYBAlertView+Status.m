//
//  YYBAlertView+Status.m
//  SavingPot365
//
//  Created by Aokura on 2018/9/21.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBAlertView+Status.h"

@implementation YYBAlertView (Status)

+ (void)showAlertViewWithStatus:(NSString *)status
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleCenter;
    
    alertView.autoHideTimeInterval = 2.0f;
    alertView.isConstraintedWithContainer = TRUE;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        [container.shadowView setLayerShadow:[UIColor colorWithHexInteger:0xAFADAD alpha:0.5f] offset:CGSizeZero radius:14.0f];
        container.contentView.backgroundColor = [UIColor blackColor];
        [container.contentView cornerRadius:8.0f];
        
        [container addLabelWithHandler:^(YYBAlertViewAction *action, UILabel *label) {
            action.margin = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);

            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
            label.numberOfLines = 0;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 3.0f;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSString *text = [status isExist] ? status : @"有些地方出错了~";
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
            [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
            label.attributedText = attributed;
        }];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
