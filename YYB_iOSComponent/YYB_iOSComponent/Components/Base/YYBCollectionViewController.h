//
//  YYBCollectionViewController.h
//  SavingPot365
//
//  Created by September on 2018/10/23.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "YYBViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingCollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBCollectionViewController : YYBViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) TPKeyboardAvoidingCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *results;

@end

NS_ASSUME_NONNULL_END
