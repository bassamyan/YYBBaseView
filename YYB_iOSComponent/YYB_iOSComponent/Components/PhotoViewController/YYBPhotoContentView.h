//
//  YYBPhotoContentView.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/27.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
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
