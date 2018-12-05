//
//  YYBPhotoSectionView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/11/3.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBNavigationBarContainer.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBPhotoSectionView : YYBNavigationBarContainer

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,copy) void (^ librarySelectedHandler)(BOOL isSelected);
- (void)sectionSelectedHandler;

@end

NS_ASSUME_NONNULL_END
