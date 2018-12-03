//
//  YYBCollectionViewController.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/23.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingCollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBCollectionViewController : YYBViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) TPKeyboardAvoidingCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *results;

@end

NS_ASSUME_NONNULL_END
