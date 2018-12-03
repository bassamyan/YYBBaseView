//
//  PHAsset+YYBPhoto.h
//  SavingPot365
//
//  Created by Aokura on 2018/9/27.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (YYBPhoto)

- (void)produceImageWithTargetSize:(CGSize)targetSize completionHandler:(void (^)(UIImage *image, NSString *filename))completionHandler;

@end
