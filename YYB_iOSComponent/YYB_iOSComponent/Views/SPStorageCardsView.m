//
//  SPStorageCardsView.m
//  SavingPot365
//
//  Created by Sniper on 2018/12/1.
//  Copyright © 2018 Tree,Inc. All rights reserved.
//

#import "SPStorageCardsView.h"
#import "SPStorageCardSettingCollectionViewCell.h"

@interface SPStorageCardsView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic) NSInteger selectedCardIndex;
@end

@implementation SPStorageCardsView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    _collectionView = [UICollectionView collectionViewWithDelagateHandler:self superView:self constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    } registerClassNames:@[@"SPStorageCardSettingCollectionViewCell"] configureHandler:^(UICollectionView *view, UICollectionViewFlowLayout *layout) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        view.contentInset = UIEdgeInsetsMake(0, 15.0f, 0, 25.0f);
        view.showsHorizontalScrollIndicator = FALSE;
    }];
    
    return self;
}

- (void)renderStorageInitialCard:(NSInteger)cardId {
    _selectedCardIndex = cardId;
    [_collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(140.0f, 130.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPStorageCardSettingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPStorageCardSettingCollectionViewCell" forIndexPath:indexPath];
    
    @weakify(self);
    cell.cardSettingActionHandler = ^{
        @strongify(self);
        if (self.showCardSettingPageHandler) {
            self.showCardSettingPageHandler();
        }
    };
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

@end
