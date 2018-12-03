//
//  UICollectionView+YYBLayout.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/23.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UICollectionView (YYBLayout)

+ (UICollectionView *)collectionViewWithDelagateHandler:(id)delegeteHandler superView:(UIView *)superView
                                             constraint:(void(^)(MASConstraintMaker *make))constraint
                                     registerClassNames:(NSArray *)registerClassNames
                                       configureHandler:(void (^)(UICollectionView *view , UICollectionViewFlowLayout *layout))configureHandler;

@end
