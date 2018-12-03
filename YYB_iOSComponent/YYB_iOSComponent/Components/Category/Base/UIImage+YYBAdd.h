//
//  UIImage+YYBAdd.h
//  Framework
//
//  Created by Sniper on 2018/2/14.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYBAdd)

// 颜色转化成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

// 高斯模糊图
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)scale:(CGFloat)scale;

+ (UIImage *)imageScreenShotUsingContext:(BOOL)useContext;

// 把图片旋转到指定角度
- (UIImage *)rotateWithDegrees:(CGFloat)degrees;

// 虚线框
+ (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

// 缩放到制定尺寸图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

// 将图片切成圆角图片
- (UIImage *)imageWithRoundedSize:(CGSize)size radius:(NSInteger)r;

// 播放GIF图片,放到imageView里面自动播放
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

// 取图片上某点的颜色值
- (UIColor *)colorAtPixel:(CGPoint)point;

// 创建单色颜色值Image
+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size;

// 对图像添加alpha值
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@end
