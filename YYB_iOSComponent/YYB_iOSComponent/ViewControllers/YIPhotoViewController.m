//
//  YIPhotoViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YIPhotoViewController.h"
#import "YICreateImageTableViewCell.h"
#import <Photos/Photos.h>
#import "YYBAlertView+Alert.h"
#import "UIViewController+YYBPhotoBrowser.h"
#import "YYBPhotoViewController.h"
#import "UIViewController+YYBPhotoViewController.h"

@interface YIPhotoViewController ()

@end

@implementation YIPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[YICreateImageTableViewCell class] forCellReuseIdentifier:@"YICreateImageTableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YICreateImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YICreateImageTableViewCell"];
    
    @weakify(self);
    @weakify(cell);
    
    cell.createImageHandler = ^{
        @strongify(self);
        [self photoPermissionWithCompleteHandler:^{
            [self photoActionHandler];
        }];
    };
    cell.reviewImagesHandler = ^(NSInteger index, CGRect rect, UICollectionView *collectionView) {
        @strongify(self);
        @strongify(cell);
        
        [self showPhotoBrowserWithImages:self.results queryImageRectHandler:^CGRect(NSInteger index) {
            return [cell imageRectWithIndex:index convertView:self.view];
        } initialImageIndex:index isDeletable:TRUE deleteActionHandler:nil reloadImageSourceHandler:^(NSInteger index) {
            [self.results removeObjectAtIndex:index];
            [self.tableView reloadData];
        } configureHandler:^(YYBPhotoBrowser * _Nonnull browser) {
            
        }];
    };
    cell.results = self.results;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = (kScreenWidth - 50.0f - 10.0f) / 3;
    NSInteger count = self.results.count < 9 ? self.results.count + 1 : self.results.count;
    NSInteger rows = (count - 1) / 3 + 1;
    return size * rows + (rows - 1) * 5.0f + 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)photoActionHandler {
    @weakify(self);
    [self showPhotoViewControllerWithMaxSelectImageCount:9 - self.results.count imagesSelectedHandler:^(NSArray * images) {
        @strongify(self);
        [self.results addObjectsFromArray:images];
        [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    } configureHandler:nil];
}

- (void)photoPermissionWithCompleteHandler:(void(^)(void))completeHandler {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async_on_main_queue(^{
                    completeHandler();
                });
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        dispatch_async_on_main_queue(^{
            completeHandler();
        });
    } else {
        [YYBAlertView showAlertViewWithTitle:@"权限请求失败"
                                      detail:@"您没有打开相册权限,打开相关设置后才能继续使用功能"
                           cancelActionTitle:@"取消" confirmActionTitle:@"前去设置" confirmActionHandler:^{
                               [NSObject openURL:UIApplicationOpenSettingsURLString];
                           }];
    }
}

@end
