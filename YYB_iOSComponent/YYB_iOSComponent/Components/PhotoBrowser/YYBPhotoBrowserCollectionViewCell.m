//
//  YYBPhotoBrowserCollectionViewCell.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/10/27.
//  Copyright © 2018 Univease Co., Ltd All rights reserved.
//

#import "YYBPhotoBrowserCollectionViewCell.h"
#import "UIImageView+YYBPhotoBrowser.h"

@interface YYBPhotoBrowserCollectionViewCell ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation YYBPhotoBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView addSubview:_iconView];
    
    _scrollView.delegate = self;
    _scrollView.contentSize = frame.size;
    [self.contentView addSubview:_scrollView];
    
    _scrollView.maximumZoomScale = 3.0f;
    _scrollView.minimumZoomScale = 1.0f;
    
    UITapGestureRecognizer *oneTaped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageItemTapedAction)];
    oneTaped.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:oneTaped];
    
    UITapGestureRecognizer *taped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shrinkHandler)];
    taped.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:taped];
    
    return self;
}

- (void)imageItemTapedAction {
    if (self.imageItemTapedHandler) {
        self.imageItemTapedHandler();
    }
}

- (void)shrinkHandler {
    [_scrollView setZoomScale:1.0f animated:TRUE];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.contentView.bounds;
    _iconView.frame = _scrollView.bounds;
}

- (void)prepareForReuse {
    _scrollView.zoomScale = 1.0f;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _iconView;
}

- (void)renderItemWithValueModel:(id)valueModel {
    [_iconView renderImageWithContent:valueModel];
}

@end
