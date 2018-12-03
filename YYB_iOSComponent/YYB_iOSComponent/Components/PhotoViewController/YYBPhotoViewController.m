//
//  YYBPhotoViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoViewController.h"
#import "YYBPhotoContentView.h"
#import "YYBPhotoCollectionViewCell.h"
#import "PHAsset+YYBPhoto.h"
#import "YYBPhotoSectionView.h"
#import "YYBPhotoSelectionsView.h"
#import "YYBAlertView+PhotoViewWaiting.h"

@interface YYBPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YYBPhotoContentViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) PHFetchResult *result;
@property (nonatomic,strong) YYBPhotoContentView *contentView;
@property (nonatomic,strong) UIView *shadeView; // 黑色遮罩

@property (nonatomic,strong) YYBNavigationBarLabel *cancelBarButton;
@property (nonatomic,strong) YYBPhotoSectionView *sectionView;
@property (nonatomic,strong) YYBPhotoSelectionsView *selectionsView;

@property (nonatomic,strong) NSMutableArray *selectedAssets;

@property (nonatomic,strong) dispatch_semaphore_t semaphore;
@property (nonatomic,strong) dispatch_queue_t queue;
@property (nonatomic,strong) YYBAlertView *alertView;

@end

@implementation YYBPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _semaphore = dispatch_semaphore_create(0);
    _queue = dispatch_queue_create("YYBPHOTOVIEWCONTROLLER.CONCURRENT.QUEUE", DISPATCH_QUEUE_CONCURRENT);
    
    self.view.clipsToBounds = TRUE;
    _selectedAssets = [NSMutableArray new];
    
    __weak typeof(self) wself = self;
    _collectionView = [UICollectionView collectionViewWithDelagateHandler:self superView:self.view constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    } registerClassNames:@[@"YYBPhotoCollectionViewCell"] configureHandler:^(UICollectionView *view, UICollectionViewFlowLayout *layout) {
        __strong typeof(self) sself = wself;
        view.backgroundColor = [UIColor whiteColor];
        view.contentInset = UIEdgeInsetsMake([sself heightForNavigationBar], 1.0f, 64.0f, 1.0f);
    }];
    
    _shadeView = [UIView viewWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.3f] superView:self.view constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    } configureHandler:^(UIView *view) {
        view.hidden = TRUE;
        view.alpha = 0.0f;
    }];
    
    _contentView = [YYBPhotoContentView viewWithSuperView:self.view constraint:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_top).offset([self heightForNavigationBar]);
        make.height.mas_equalTo(320.0f);
    } configureHandler:^(YYBPhotoContentView *view) {
        __strong typeof(self) sself = wself;
        view.delegate = sself;
    }];
    
    _selectionsView = [YYBPhotoSelectionsView viewWithSuperView:self.view constraint:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50.0f + [UIDevice safeAreaBottom]);
    } configureHandler:^(YYBPhotoSelectionsView *view) {
        __strong typeof(self) sself = wself;
        view.hidden = [sself isAppendingImagesEnable] == FALSE;
    }];
    
    _selectionsView.finishSelectedHandler = ^{
        __strong typeof(self) sself = wself;
        if (sself.isImageRequired == TRUE) {
            [sself doRequireImages];
        } else {
            if (sself.imageAssetsQueryHandler) {
                sself.imageAssetsQueryHandler(sself.selectedAssets);
            }
            [sself dismissViewControllerAnimated:TRUE completion:nil];
        }
    };
    
    [self takePhotoAlbumDatasource];
}

- (void)doRequireImages {
    dispatch_async(_queue, ^{
        NSMutableArray *results = [NSMutableArray new];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.alertView = [YYBAlertView showPhotoViewWaitingAlertView];
        });
        
        __weak typeof(self) wself = self;
        for (NSInteger index = 0; index < self.selectedAssets.count; index ++) {
            PHAsset *asset = [self.selectedAssets objectAtIndex:index];
            [asset produceImageWithTargetSize:CGSizeZero completionHandler:^(UIImage *image, NSString *filename) {
                __strong typeof(self) sself = wself;
                [results addObject:image];
                dispatch_semaphore_signal(sself.semaphore);
            }];
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.alertView closeAlertView];
            if (self.imageAssetsQueryHandler) {
                self.imageAssetsQueryHandler(results);
            }
            [self dismissViewControllerAnimated:TRUE completion:nil];
        });
    });
}

- (void)configureNavigationView {
    __weak typeof(self) wself = self;
    _cancelBarButton = [YYBNavigationBarLabel labelWithConfigureHandler:^(YYBNavigationBarLabel *container, UILabel *view) {
        container.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 15.0f, 0, 0);
        
        view.text = @"取消";
        view.textColor = [UIColor blackColor];
        view.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightLight];
    } tapedActionHandler:^(YYBNavigationBarContainer *view) {
        __strong typeof(self) sself = wself;
        [sself dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    _sectionView = [[YYBPhotoSectionView alloc] init];
    _sectionView.contentSize = CGSizeMake(200.0f, 40.0f);
    _sectionView.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 0, 0, 0);
    _sectionView.librarySelectedHandler = ^(BOOL isSelected) {
        __strong typeof(self) sself = wself;
        [UIView animateWithDuration:0.25f animations:^{
            if (isSelected) {
                sself.shadeView.hidden = FALSE;
                sself.shadeView.alpha = 1.0f;
                sself.contentView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(sself.contentView.frame));
            } else {
                sself.shadeView.alpha = 0.0f;
                sself.contentView.transform = CGAffineTransformIdentity;
            }
        } completion:^(BOOL finished) {
            if (isSelected == FALSE) {
                sself.shadeView.hidden = TRUE;
            }
        }];
    };
    
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationBar.titleBarContainer = _sectionView;
    self.navigationBar.leftBarContainers = @[_cancelBarButton];
    self.navigationBar.bottomLayerView.backgroundColor = [UIColor colorWithHexInteger:0xEBEBEB];
}

- (void)photoContentViewSelectedResults:(PHFetchResult *)assetsResult collection:(PHAssetCollection *)collection {
    _result = assetsResult;
    [_sectionView sectionSelectedHandler];
    _sectionView.contentLabel.text = collection.localizedTitle;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)takePhotoAlbumDatasource {
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];

    // Videos,Bursts,Hidden,Camera Roll,Selfies,Panoramas,ecently Deleted,Time-lapse,Favorites,Recently Added,Slo-mo,Screenshots,Portrait,Live Photos,Animated,Long Exposure
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    _contentView.results = result;
    
    __weak typeof(self) wself = self;
    [result enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * stop) {
        if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
            __strong typeof(self) sself = wself;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            [sself photoContentViewSelectedResults:fetchResult collection:collection];
            *stop = YES;
        }
    }];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = (CGRectGetWidth(self.view.frame) - 5.0f) / 4;
    return CGSizeMake(size, size);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYBPhotoCollectionViewCell" forIndexPath:indexPath];
    PHAsset *asset = [_result objectAtIndex:indexPath.row];
    
    __weak typeof(self) wself = self;
    cell.checkSelectionHandler = ^BOOL{
        __strong typeof(self) sself = wself;
        return [sself selectionStatusWithAsset:asset];
    };
    
    cell.checkAppendEnableHandler = ^BOOL{
        __strong typeof(self) sself = wself;
        return [sself isAppendingImagesEnable];
    };
    
    cell.selectActionHandler = ^{
        __strong typeof(self) sself = wself;
        BOOL isSelected = [sself selectionStatusWithAsset:asset];
        if (isSelected) {
            [sself.selectedAssets removeObject:asset];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSELECTEDNOTIFICATION" object:nil];
        } else {
            if (sself.selectedAssets.count < sself.maxAllowedImages) {
                [sself.selectedAssets addObject:asset];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSELECTEDNOTIFICATION" object:nil];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSAPPENDNOTIFICATION" object:nil];
        [sself.selectionsView renderButtonWithImagesCount:sself.selectedAssets.count];
    };
    
    [cell renderItemWithAsset:asset selectionStatus:[self selectionStatusWithAsset:asset] isMultipleImagesRequired:_isMultipleImagesRequired isAppendImageEnable:[self isAppendingImagesEnable]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _result.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [_result objectAtIndex:indexPath.row];
    if (_isMultipleImagesRequired == FALSE) {
        if (self.imageAssetQueryHandler) {
            self.imageAssetQueryHandler(asset);
        }
        [self dismissViewControllerAnimated:TRUE completion:nil];
    } else {
        // 查看图片浏览器
    }
}

- (BOOL)selectionStatusWithAsset:(PHAsset *)asset {
    if (_isMultipleImagesRequired == FALSE) {
        return FALSE;
    }
    return [_selectedAssets containsObject:asset];
}

- (BOOL)isAppendingImagesEnable {
    if (_isMultipleImagesRequired == TRUE) {
        return _selectedAssets.count != _maxAllowedImages;
    } else {
        return TRUE;
    }
}

@end
