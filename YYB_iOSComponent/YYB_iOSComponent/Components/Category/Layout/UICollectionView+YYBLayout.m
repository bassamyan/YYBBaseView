//
//  UICollectionView+YYBLayout.m
//  SavingPot365
//
//  Created by Sniper on 2018/9/23.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "UICollectionView+YYBLayout.h"

@implementation UICollectionView (YYBLayout)

+ (UICollectionView *)collectionViewWithDelagateHandler:(id)delegeteHandler superView:(UIView *)superView constraint:(void (^)(MASConstraintMaker *))constraint registerClassNames:(NSArray *)registerClassNames configureHandler:(void (^)(UICollectionView *, UICollectionViewFlowLayout *))configureHandler {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    view.backgroundColor = [UIColor whiteColor];
    
    if (registerClassNames && registerClassNames.count > 0) {
        for (NSString *className in registerClassNames) {
            Class class = NSClassFromString(className);
            if (class) {
                [view registerClass:class forCellWithReuseIdentifier:className];
            }
        }
    }
    if (delegeteHandler) {
        view.delegate = delegeteHandler;
        view.dataSource = delegeteHandler;
    }
    if (superView) {
        [superView addSubview:view];
    }
    if (constraint) {
        [view mas_makeConstraints:constraint];
    }
    if (configureHandler) {
        configureHandler(view ,layout);
    }
    return view;
}

@end
