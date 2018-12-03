//
//  YYBPhotoContentView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "YYBLayout.h"

@protocol YYBPhotoContentViewDelegate <NSObject>

- (void)photoContentViewSelectedResults:(PHFetchResult *)assetsResult collection:(PHAssetCollection *)collection;

@end

@interface YYBPhotoContentView : UIView

@property (nonatomic,weak) id<YYBPhotoContentViewDelegate> delegate;
@property (nonatomic,strong) PHFetchResult *results;

@end
