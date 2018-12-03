//
//  PHAsset+YYBPhoto.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/9/27.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "PHAsset+YYBPhoto.h"

@implementation PHAsset (YYBPhoto)

- (void)produceImageWithTargetSize:(CGSize)targetSize completionHandler:(void (^)(UIImage *, NSString *))completionHandler
{
    if (CGSizeEqualToSize(targetSize, CGSizeZero)) {
        targetSize = CGSizeMake(self.pixelWidth,self.pixelHeight);
    }
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:targetSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue] && result;
                                                if (downloadFinined) {
                                                    if (completionHandler) {
                                                        NSString *filename = [info objectForKey:@"PHImageFileURLKey"];
                                                        completionHandler(result,filename);
                                                    }
                                                }
                                            }];
}

@end
