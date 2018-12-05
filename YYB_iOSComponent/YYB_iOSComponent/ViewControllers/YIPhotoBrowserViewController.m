//
//  YIPhotoBrowserViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/4.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YIPhotoBrowserViewController.h"
#import "YIImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYBPhotoBrowser.h"
#import "YYBPhotoBrowserTransition.h"
#import "UIViewController+YYBPhotoBrowser.h"

@interface YIPhotoBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *results;
@property (nonatomic,strong) YYBPhotoBrowserTransition *transition;

@end

@implementation YIPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _transition = [[YYBPhotoBrowserTransition alloc] init];
    
    _collectionView = [UICollectionView collectionViewWithDelagateHandler:self superView:self.view constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    } registerClassNames:@[@"YIImageCollectionViewCell"] configureHandler:^(UICollectionView *view, UICollectionViewFlowLayout *layout) {
        view.contentInset = UIEdgeInsetsMake([self heightForNavigationBar], 0, 0, 0);
    }];
    
    _results = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543907792858&di=6d9dd196cfe73071203afaabf04ab0fe&imgtype=0&src=http%3A%2F%2Fbpic.ooopic.com%2F15%2F92%2F59%2F15925993-f2d5e10a60d9d4c215d0f8ff4f75ce25-0.jpg",
                 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543907792855&di=c0e79e73c0637ed67a991fcc48a8199c&imgtype=0&src=http%3A%2F%2Fpic13.nipic.com%2F20110303%2F3888028_133816414181_2.jpg",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4",
                 @"https://avatars0.githubusercontent.com/u/10416225?s=400&u=e78c228cf8f327c27fe39959da7114623ab9916d&v=4"].mutableCopy;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = (kScreenWidth - 2.0f) / 3;
    return CGSizeMake(size, size);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YIImageCollectionViewCell" forIndexPath:indexPath];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:[_results objectAtIndex:indexPath.row]]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _results.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    [self showPhotoBrowserWithImages:_results queryImageRectHandler:^CGRect(NSInteger index) {
        return [self rectWithCollectionView:collectionView indexPath:indexPath];
    } initialImageIndex:indexPath.row isDeletable:TRUE deletionCheckHandler:nil reloadImageSourceHandler:^(NSInteger index) {
        @strongify(self);
        [self.results removeObjectAtIndex:index];
        [self.collectionView reloadData];
    } configureHandler:^(YYBPhotoBrowser * browser) {

    }];
    
//    [self showPhotoBrowserWithImage:[_results objectAtIndex:indexPath.row] configureHandler:^(YYBPhotoBrowser * _Nonnull browser) {
//        
//    }];
}

- (CGRect)rectWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    YIImageCollectionViewCell *cell = (YIImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    return [collectionView convertRect:cell.frame toView:self.view]; // 将collectionView上的cell尺寸映射到self.view上
}

@end
