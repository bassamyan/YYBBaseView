//
//  UIImageView+YYBPhotoBrowser.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/4.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "UIImageView+YYBPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+YYBAdd.h"

@implementation UIImageView (YYBPhotoBrowser)

- (void)renderImageWithContent:(id)content {
    if ([content isKindOfClass:[UIImage class]]) {
        self.image = content;
    } else if ([content isKindOfClass:[NSString class]]) {
        if ([content isContainsChinese]) {
            [self sd_setImageWithURL:[NSURL URLWithString:[content imageURLEncode]]];
        } else {
            [self sd_setImageWithURL:[NSURL URLWithString:content]];
        }
    }
}

@end
