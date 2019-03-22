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
#import "YYBPhotoSectionView.h"
#import "YYBPhotoSelectionsView.h"
#import "YYBAlertView+Waiting.h"
#import "PHAsset+YYBPhotoViewController.h"
#import "YYBLayout.h"

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

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _maxRequiredImages = 9;
    _isEditSelectedImageEnable = TRUE;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = TRUE;
    
    _semaphore = dispatch_semaphore_create(0);
    _queue = dispatch_queue_create("YYBPHOTOVIEWCONTROLLER.CONCURRENT.QUEUE", DISPATCH_QUEUE_CONCURRENT);
    _selectedAssets = [NSMutableArray new];
    
    __weak typeof(self) wself = self;
    _collectionView = [UICollectionView collectionViewWithDelagateHandler:self superView:self.view constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    } registerClassNames:@[@"YYBPhotoCollectionViewCell"] configureHandler:^(UICollectionView *view, UICollectionViewFlowLayout *layout) {
        view.backgroundColor = [UIColor whiteColor];
        view.contentInset = UIEdgeInsetsMake([wself heightForNavigationBar], 1.0f, 64.0f, 1.0f);
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
        view.delegate = wself;
    }];
    
    if (_isEditSelectedImageEnable == TRUE) {
        _selectionsView = [YYBPhotoSelectionsView viewWithSuperView:self.view constraint:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(50.0f + [UIDevice safeAreaBottom]);
        } configureHandler:^(YYBPhotoSelectionsView *view) {
            view.hidden = [wself isAppendingImagesEnable] == FALSE;
        }];
        
        _selectionsView.finishSelectedHandler = ^{
            if (wself.isFormattedByUIImage == TRUE) {
                [wself produceImageWithAssets];
            } else {
                if (wself.imageResultsQueryHandler) {
                    wself.imageResultsQueryHandler(wself.selectedAssets);
                }
                [wself dismissViewControllerAnimated:TRUE completion:nil];
            }
        };
    }
    
    [self takePhotoAlbumDatasource];
}

- (void)produceImageWithAssets {
    dispatch_async(_queue, ^{
        NSMutableArray *results = [NSMutableArray new];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.alertView = [YYBAlertView showPhotoViewWaitingAlertView];
        });
        
        for (NSInteger index = 0; index < self.selectedAssets.count; index ++) {
            PHAsset *asset = [self.selectedAssets objectAtIndex:index];
            
            __weak typeof(self) wself = self;
            [asset produceImageWithTargetSize:CGSizeZero completionHandler:^(UIImage *image, NSString *filename) {
                [results addObject:image];
                dispatch_semaphore_signal(wself.semaphore);
            }];
            
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.alertView closeAlertView];
            
            if (self.imageResultsQueryHandler) {
                self.imageResultsQueryHandler(results);
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
        [wself dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    _sectionView = [[YYBPhotoSectionView alloc] init];
    _sectionView.contentSize = CGSizeMake(200.0f, 40.0f);
    _sectionView.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 0, 0, 0);
    _sectionView.librarySelectedHandler = ^(BOOL isSelected) {
        [UIView animateWithDuration:0.25f animations:^{
            if (isSelected) {
                wself.shadeView.hidden = FALSE;
                wself.shadeView.alpha = 1.0f;
                wself.contentView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(wself.contentView.frame));
            } else {
                wself.shadeView.alpha = 0.0f;
                wself.contentView.transform = CGAffineTransformIdentity;
            }
        } completion:^(BOOL finished) {
            if (isSelected == FALSE) {
                wself.shadeView.hidden = TRUE;
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
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            [wself photoContentViewSelectedResults:fetchResult collection:collection];
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
        return [wself selectionStatusWithAsset:asset];
    };
    
    cell.checkAppendEnableHandler = ^BOOL{
        return [wself isAppendingImagesEnable];
    };
    
    cell.selectActionHandler = ^{
        BOOL isSelected = [wself selectionStatusWithAsset:asset];
        if (isSelected) {
            [wself.selectedAssets removeObject:asset];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSELECTEDNOTIFICATION" object:nil];
        } else {
            if (wself.selectedAssets.count < wself.maxRequiredImages) {
                [wself.selectedAssets addObject:asset];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSELECTEDNOTIFICATION" object:nil];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YYBPHOTOSAPPENDNOTIFICATION" object:nil];
        [wself.selectionsView renderButtonWithImagesCount:wself.selectedAssets.count];
    };
    
    [cell renderItemWithAsset:asset selectionStatus:[self selectionStatusWithAsset:asset] isMultipleImagesRequired:_isEditSelectedImageEnable isAppendImageEnable:[self isAppendingImagesEnable]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _result.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [_result objectAtIndex:indexPath.row];
    if (_isEditSelectedImageEnable == FALSE) {
        if (_isFormattedByUIImage) {
            [_selectedAssets addObject:asset];
            [self produceImageWithAssets];
        } else {
            if (self.imageResultQueryHandler) {
                self.imageResultQueryHandler(asset);
            }
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
    } else {
        // 查看图片浏览器
    }
}

- (BOOL)selectionStatusWithAsset:(PHAsset *)asset {
    if (_isEditSelectedImageEnable == FALSE) {
        return FALSE;
    }
    return [_selectedAssets containsObject:asset];
}

- (BOOL)isAppendingImagesEnable {
    if (_isEditSelectedImageEnable == TRUE) {
        return _selectedAssets.count != _maxRequiredImages;
    } else {
        return TRUE;
    }
}

@end
