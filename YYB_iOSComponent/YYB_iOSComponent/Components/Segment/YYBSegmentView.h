//
//  YYBSegmentView.h
//  SavingPot365
//
//  Created by Sniper on 2019/2/8.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBSegmentView : UIView

@property (nonatomic,strong) UIColor *detailTintColor, *selectedTintColor;
@property (nonatomic,strong) NSArray *segmentTitles;

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,copy) void (^ indexSelectedHandler)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
