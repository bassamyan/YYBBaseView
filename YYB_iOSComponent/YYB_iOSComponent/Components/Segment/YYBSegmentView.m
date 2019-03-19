//
//  YYBSegmentView.m
//  SavingPot365
//
//  Created by Sniper on 2019/2/8.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBSegmentView.h"

@interface YYBSegmentView ()
@property (nonatomic,strong) CALayer *bottomLayer, *backgroundLayer;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic) BOOL markedUpdate;

@end

@implementation YYBSegmentView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _detailTintColor = [UIColor colorWithRed:176.0f / 255.0f green:176.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f];
    _selectedTintColor = [UIColor blackColor];
    
    _backgroundLayer = [CALayer layer];
    _backgroundLayer.backgroundColor = [UIColor colorWithRed:246.0f / 255.0f green:246.0f / 255.0f blue:246.0f / 255.0f alpha:1.0f].CGColor;
    [self.layer addSublayer:_backgroundLayer];
    
    _bottomLayer = [CALayer layer];
    _bottomLayer.backgroundColor = _selectedTintColor.CGColor;
    [self.layer addSublayer:_bottomLayer];
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    return self;
}

- (void)setDetailTintColor:(UIColor *)detailTintColor {
    _detailTintColor = detailTintColor;
    _backgroundLayer.backgroundColor = detailTintColor.CGColor;
}

- (void)setSelectedTintColor:(UIColor *)selectedTintColor {
    _selectedTintColor = selectedTintColor;
    _bottomLayer.backgroundColor = selectedTintColor.CGColor;
}

- (void)setSegmentTitles:(NSArray *)segmentTitles {
    _segmentTitles = segmentTitles;
    [self reloadSegmentItems];
}

- (void)reloadSegmentItems {
    _markedUpdate = TRUE;
    
    for (UIView *sub in _contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    if (_segmentTitles && _segmentTitles.count > 0) {
        for (NSInteger index = 0; index < _segmentTitles.count; index ++) {
            UIButton *button = [[UIButton alloc] init];
            [button setTitleColor:self.detailTintColor forState:0];
            [button setTitleColor:self.selectedTintColor forState:UIControlStateSelected];
            [button setTitle:_segmentTitles[index] forState:0];
            button.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
            button.tag = index;
            [button addTarget:self action:@selector(segmentItemTaped:) forControlEvents:1<<6];
            [_contentView addSubview:button];
            
            if (index == _selectedIndex) {
                _selectedButton.selected = FALSE;
                _selectedButton = button;
                _selectedButton.selected = TRUE;
            }
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    _bottomLayer.transform = CATransform3DIdentity;
    [UIView commitAnimations];
}

- (void)segmentItemTaped:(UIButton *)sender {
    if (_selectedButton == sender) {
        return;
    }
    
    _selectedButton.selected = FALSE;
    _selectedButton = sender;
    _selectedButton.selected = TRUE;
    
    if (self.indexSelectedHandler) {
        self.indexSelectedHandler(sender.tag);
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    
    CGFloat x = CGRectGetWidth(sender.frame) * sender.tag;
    _bottomLayer.transform = CATransform3DMakeTranslation(x, 0, 0);
    [UIView commitAnimations];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_markedUpdate == TRUE) {
        NSInteger count = _segmentTitles.count;
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        
        for (UIView *sub in _contentView.subviews) {
            sub.frame = CGRectMake(sub.tag * (width / count), 0, width / count, height);
        }
        
        CGFloat layer_size = 4.0f;
        _backgroundLayer.frame = CGRectMake(0, height - 0.5f, width, 0.5f);
        _bottomLayer.frame = CGRectMake(_selectedIndex * (width / count), height - layer_size, width / count, layer_size);
        _contentView.frame = self.bounds;
        
        _markedUpdate = FALSE;
    }
}

@end
