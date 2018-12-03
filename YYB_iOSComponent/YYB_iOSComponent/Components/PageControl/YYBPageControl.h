//
//  YYBPageControl.h
//  YYB_iOSComponent
//
//  Created by Sniper on 16/7/27.
//  Copyright © 2016年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , YYBPageControlType) {
    YYBPageControlTypeCircle = 0,
    YYBPageControlTypeRect = 1,
};

@interface YYBPageControl : UIView

@property (nonatomic) YYBPageControlType type;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numbersOfPages;

@property (nonatomic,strong) UIColor *currentPageIndicatorColor;
@property (nonatomic,strong) UIColor *othersPageIndicatorColor;

@property (nonatomic) CGSize sizeForPageIndicator;
@property (nonatomic) CGFloat pageItemPadding;

@end
