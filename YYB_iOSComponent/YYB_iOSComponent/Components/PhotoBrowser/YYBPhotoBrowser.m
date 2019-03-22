//
//  YYBPhotoBrowser.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/27.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoBrowser.h"
#import "YYBPhotoBrowserCollectionViewCell.h"
#import "UIImageView+YYBPhotoBrowser.h"
#import "UIImage+YYBAdd.h"
#import "NSBundle+YYBAdd.h"

@interface YYBPhotoBrowser () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIPanGestureRecognizer *pan;
@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) YYBNavigationBarImageView *deleteBarButton;

@end

@implementation YYBPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = TRUE;
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[YYBPhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"YYBPhotoBrowserCollectionViewCell"];
    
    _iconView = [UIImageView new];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.clipsToBounds = TRUE;
    _iconView.hidden = TRUE;
    _iconView.frame = self.view.bounds;
    [self.contentView addSubview:_iconView];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(recognizerUpdate:)];
    [self.contentView addGestureRecognizer:_pan];
    
    _transition.pan = nil;
    
    [self configureInitialImage];
}

- (void)configureInitialImage {
    if (_images.count > _initialImageIndex) {
        id image = [_images objectAtIndex:_initialImageIndex];
        [_iconView renderImageWithContent:image];
    }
}

- (void)recognizerUpdate:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
    
    CGFloat scale = 1 - (translation.y / CGRectGetHeight(self.view.frame));
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            _transition.pan = pan;
            _collectionView.hidden = TRUE;
            _iconView.hidden = FALSE;
            
            NSInteger index = [self pageIndex];
            _transition.imageURL = [_images objectAtIndex:index];
            _transition.fromImageRect = self.queryImageItemRectHandler(index);
            
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            _iconView.center = CGPointMake(CGRectGetMidX(self.view.frame) + translation.x * scale, CGRectGetMidY(self.view.frame) + translation.y);
            _iconView.transform = CGAffineTransformMakeScale(scale, scale);
        }
            break;
        case UIGestureRecognizerStateEnded: {
            _transition.finishImageRect = _iconView.frame;
            if (scale > 0.95f) {
                [UIView animateWithDuration:0.2f animations:^{
                    self.iconView.center = self.view.center;
                    self.iconView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    self.iconView.hidden = TRUE;
                    self.collectionView.hidden = FALSE;
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (CGSize)aspectFitSizeWithSize:(CGSize)aspectSize contentSize:(CGSize)contentSize {
    CGSize result_size = aspectSize;
    if (aspectSize.width > contentSize.width || aspectSize.height > contentSize.height) {
        if (contentSize.width / contentSize.height > aspectSize.width / aspectSize.height) {
            result_size.height = contentSize.height;
            result_size.width = aspectSize.width * contentSize.height / aspectSize.height;
        } else {
            result_size.width = contentSize.width;
            result_size.height = contentSize.width / (aspectSize.width / aspectSize.height);
        }
    }
    
    CGFloat max = MAX(result_size.width, result_size.height);
    return CGSizeMake(max, max);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_initialImageIndex < _images.count) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_initialImageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:FALSE];
    } else {
        if (_images.count > 0) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:FALSE];
        }
    }
}

- (void)deleteImageAtIndex:(NSInteger)index {
    if (self.images.count == 1) {
        [self.images removeAllObjects];
        [self dismissViewControllerAnimated:TRUE completion:nil];
    } else {
        [self.images removeObjectAtIndex:index];
    }
    
    if (self.deleteImageActionHandler) {
        self.deleteImageActionHandler(index);
    } else if (self.reloadImagesHandler) {
        self.reloadImagesHandler();
    }
    
    [self scrollViewDidScroll:self.collectionView];
    [self.collectionView reloadData];
}

- (void)configureNavigationView {
    [self.navigationBackBarButton setBarButtonImage:[[NSBundle imageWithBundleName:@"Icon_PhotoBrowser" imageName:@"ic_yyb_pb_navigation_back_white"] scale:2.0f] controlState:0];
    [self.navigationBackBarButton setBarButtonTextColor:[UIColor whiteColor] controlState:0];
    
    if (_images.count > 1) {
        self.navigationBar.titleBarButton.label.text = [NSString stringWithFormat:@"1 / %ld",_images.count];
        self.navigationBar.titleBarButton.label.textColor = [UIColor whiteColor];
        self.navigationBar.titleBarButton.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 0, 0, 0);
        self.navigationBar.titleBarButton.label.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
    }

    self.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationBar.alpha = 0.0f;
    
    if (self.isDeletionValid == TRUE) {
        @weakify(self);
        _deleteBarButton = [YYBNavigationBarContainer imageViewWithConfigureHandler:^(YYBNavigationBarImageView *container, UIImageView *view) {
            container.contentSize = CGSizeMake(20.0f, 24.0f);
            container.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 0, 0, 22.5f);
            
            view.image = [NSBundle imageWithBundleName:@"Icon_PhotoBrowser" imageName:@"ic_yyb_pb_delete"];
        } tapedActionHandler:^(YYBNavigationBarContainer *view) {
            @strongify(self);
            if (self.deleteImageQueryHandler) {
                self.deleteImageQueryHandler([self pageIndex]);
            }
        }];
        
        self.navigationBar.rightBarContainers = @[_deleteBarButton];
    }
}

- (BOOL)navigationBackBarButtonHandler {
    _transition.pan = nil;
    [self dismissViewControllerAnimated:TRUE completion:nil];
    return FALSE;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.frame);
    NSInteger index = scrollView.contentOffset.x / width;
    self.navigationBar.titleBarButton.label.text = [NSString stringWithFormat:@"%ld / %ld",index + 1,_images.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_iconView renderImageWithContent:[_images objectAtIndex:[self pageIndex]]];
}

- (NSInteger)pageIndex {
    CGFloat width = CGRectGetWidth(_collectionView.frame);
    return _collectionView.contentOffset.x / width;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYBPhotoBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYBPhotoBrowserCollectionViewCell" forIndexPath:indexPath];
    [cell renderItemWithValueModel:[_images objectAtIndex:indexPath.row]];
    
    @weakify(self);
    cell.imageItemTapedHandler = ^{
        @strongify(self);
        [UIView animateWithDuration:0.25f animations:^{
            self.navigationBar.alpha = (self.navigationBar.alpha == 1.0f ? 0.0f : 1.0f);
        }];
    };
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _images.count;
}

@end
