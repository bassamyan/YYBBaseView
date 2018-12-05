//
//  YICreateImageTableViewCell.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/5.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YICreateImageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *results;

@property (nonnull,copy) void (^ createImageHandler)(void);
@property (nonnull,copy) void (^ reviewImagesHandler)(NSInteger index, CGRect rect, UICollectionView *collectionView);

- (CGRect)imageRectWithIndex:(NSInteger)index convertView:(UIView *)convertView;

@end

NS_ASSUME_NONNULL_END
