//
//  YYBPlaceholderTextView.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/8/6.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBPlaceholderTextView : UITextView

// 修改控件的内边距用‘textContainerInset’属性
// 占位字符串
@property (nonatomic,copy) NSString *placeHolder;

// 控件占位文字属性
// 默认‘黑色’ 0.4alpha的颜色 15号字体
@property (nonatomic,strong) NSDictionary *placeHolderTextAttributes;
@property (nonatomic) NSTextAlignment placeHolderTextAlignment; ///> default to left

@end
