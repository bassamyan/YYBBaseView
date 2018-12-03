//
//  YYBAlertView+Animation.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/1.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBAlertView+Animation.h"

@implementation YYBAlertView (Animation)

- (void)addSheetStyleAnimation
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.createRectHandler = ^CGRect(NSInteger index, YYBAlertViewContainer *container) {
        CGSize contentSize = container.contentSize;
        return CGRectMake((width - contentSize.width) / 2, height - contentSize.height, contentSize.width, contentSize.height);
    };
    
    __weak typeof(self) wself = self;
    self.showContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container) {
        __strong typeof(self) sself = wself;
        
        container.transform = CGAffineTransformMakeTranslation(0, container.contentSize.height);
        sself.backgroundView.alpha = 0.0f;
        
        [UIView animateWithDuration:0.2f animations:^{
            container.transform = CGAffineTransformIdentity;
            sself.backgroundView.alpha = 1.0f;
        }];
        
        return TRUE;
    };
    
    self.closeContainerHandler = ^BOOL(NSInteger index, YYBAlertViewContainer *container, void (^removeSubviewsHandler)(void)) {
        __strong typeof(self) sself = wself;
        
        sself.backgroundView.alpha = 1.0f;
        [UIView animateWithDuration:0.2f animations:^{
            container.transform = CGAffineTransformMakeTranslation(0, container.contentSize.height);
            sself.backgroundView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            removeSubviewsHandler();
        }];
        
        return TRUE;
    };
}

@end
