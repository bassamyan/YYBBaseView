//
//  YICreateImageTableViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YICreateImageTableViewCell.h"
#import "YICreateImageCollectionViewCell.h"

@interface YICreateImageTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation YICreateImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    _collectionView = [UICollectionView collectionViewWithDelagateHandler:self superView:self.contentView constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    } registerClassNames:@[@"YICreateImageCollectionViewCell"] configureHandler:^(UICollectionView *view, UICollectionViewFlowLayout *layout) {
        view.contentInset = UIEdgeInsetsMake(25.0f, 25.0f, 25.0f, 25.0f);
    }];
    
    return self;
}

- (CGRect)imageRectWithIndex:(NSInteger)index convertView:(nonnull UIView *)convertView {
    if (index < _results.count) {
        YICreateImageCollectionViewCell *cell = (YICreateImageCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        return [_collectionView convertRect:cell.frame toView:convertView];
    }
    return CGRectZero;
}

- (void)setResults:(NSMutableArray *)results {
    _results = results;
    [_collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = (kScreenWidth - 50.0f - 10.0f) / 3;
    return CGSizeMake(size, size);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YICreateImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YICreateImageCollectionViewCell" forIndexPath:indexPath];
    if (_results.count == indexPath.row && _results.count < 9) {
        [cell configureIcon:[UIImage imageNamed:@"ic_icon_add"] imageURL:nil];
    } else {
        [cell configureIcon:[_results objectAtIndex:indexPath.row] imageURL:nil];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_results.count < 9) {
        return _results.count + 1;
    } else {
        return _results.count;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _results.count && _results.count < 9) {
        if (self.createImageHandler) {
            self.createImageHandler();
        }
    } else {
        if (self.reviewImagesHandler) {
            YICreateImageCollectionViewCell *cell = (YICreateImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            self.reviewImagesHandler(indexPath.row, cell.frame, collectionView);
        }
    }
}

@end
