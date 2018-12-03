//
//  YYBCollectionViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/23.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBCollectionViewController.h"

@interface YYBCollectionViewController ()

@end

@implementation YYBCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _collectionView = [[TPKeyboardAvoidingCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    _collectionView.contentInset = UIEdgeInsetsMake([self heightForNavigationBar], 0, 0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _results.count;
}

@end
