//
//  YYBPhotoContentView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoContentView.h"

@interface YYBPhotoContentView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation YYBPhotoContentView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _tableView = [UITableView tableViewWithDelagateHandler:self superView:self constraint:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    } registerClassNames:@[@"YYBAlbumTableViewCell"] configureHandler:^(UITableView *view) {
        
    }];
    
    return self;
}

- (void)setResults:(PHFetchResult *)results {
    _results = results;
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYBAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYBAlbumTableViewCell"];
    cell.collection = [_results objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollection *collection = [_results objectAtIndex:indexPath.row];
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:option];
    
    [self.delegate photoContentViewSelectedResults:result collection:collection];
}

@end
