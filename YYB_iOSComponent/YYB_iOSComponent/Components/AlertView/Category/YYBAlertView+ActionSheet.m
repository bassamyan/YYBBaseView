//
//  YYBAlertView+ActionSheet.m
//  SavingPot365
//
//  Created by September on 2018/10/14.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YYBAlertView+ActionSheet.h"

@implementation YYBAlertView (ActionSheet)

+ (void)showAlertActionSheetWithActions:(NSArray *)actions actionTapedHandler:(YYBAlertViewActionHandler)actionTapedHandler
{
    YYBAlertView *alertView = [[YYBAlertView alloc] init];
    alertView.backgroundView.backgroundColor = [UIColor colorWithHexInteger:0x000000 alpha:0.6f];
    alertView.displayAnimationStyle = YYBAlertViewAnimationStyleBottom;
    
    [alertView addContainerViewWithHandler:^(YYBAlertViewContainer *container) {
        container.minimalWidth = [UIScreen mainScreen].bounds.size.width;
        container.backgroundColor = [UIColor whiteColor];
        
        for (NSInteger index = 0; index < actions.count; index ++)
        {
            [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
                if (index == 0)
                {
                    action.margin = UIEdgeInsetsMake(20.0f, 22.5f, 10.0f, 22.5f);
                }
                else
                {
                    action.margin = UIEdgeInsetsMake(0, 22.5f, 10.0f, 22.5f);
                }
                action.size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 50.0f, 45.0f);
                
                [button setBackgroundImage:[UIColor colorWithHexInteger:0xF5F5F5].colorImage forState:0];
                [button setBackgroundImage:[UIColor colorWithHexInteger:0xEDEDED].colorImage forState:UIControlStateHighlighted];
                
                [button cornerRadius:22.5f];
                button.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
                [button setTitle:[actions objectAtIndex:index] forState:0];
                [button setTitleColor:[UIColor blackColor] forState:0];
                
            } tapedOnHandler:actionTapedHandler];
        }
        
        [container addActionWithHandler:^(YYBAlertViewAction *action, UIButton *button) {
            action.margin = UIEdgeInsetsMake(10.0f, 22.5f, 20.0f + [UIDevice safeAreaBottom], 22.5f);
            action.size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 50.0f, 45.0f);
            
            button.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
            [button setTitleColor:[UIColor colorWithHexInteger:0xC0C0C0] forState:0];
            [button setTitle:@"取消" forState:0];
            
        } tapedOnHandler:nil];
    }];
    
    [alertView showAlertViewOnKeyWindow];
}

@end
