//
//  UITableView+YYBLayout.h
//  SavingPot365
//
//  Created by Sniper on 2018/9/24.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UITableView (YYBLayout)

+ (UITableView *)tableViewWithDelagateHandler:(id)delegeteHandler superView:(UIView *)superView
                                   constraint:(void(^)(MASConstraintMaker *make))constraint
                           registerClassNames:(NSArray *)registerClassNames
                             configureHandler:(void (^)(UITableView *view))configureHandler;

@end
