//
//  PHAsset+YYBPhoto.h
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (YYBPhotoViewController)

- (void)produceImageWithTargetSize:(CGSize)targetSize completionHandler:(void (^)(UIImage *image, NSString *filename))completionHandler;

@end
