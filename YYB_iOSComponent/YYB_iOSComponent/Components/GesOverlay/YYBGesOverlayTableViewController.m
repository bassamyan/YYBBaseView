//
//  YYBGesOverlayTableViewController.m
//  SavingPot365
//
//  Created by Sniper on 2019/1/30.
//  Copyright © 2019 Univease Co., Ltd. All rights reserved.
//

#import "YYBGesOverlayTableViewController.h"

@interface YYBGesOverlayTableViewController () <UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIPanGestureRecognizer *pan;

@end

@implementation YYBGesOverlayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.layer.cornerRadius = [self contentRadius];
    self.view.layer.masksToBounds = TRUE;
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(recognizerUpdate:)];
    _pan.delegate = self;
    [self.tableView addGestureRecognizer:_pan];
    
    self.tableView.frame = CGRectMake(0, 50.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 50.0f);
}

- (CGRect)frameForNavigarionBar {
    return CGRectMake(0, 50.0f, CGRectGetWidth(self.view.frame), [self heightForNavigationBar]);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == _pan) {
        CGFloat y = self.tableView.contentOffset.y;
        // 当tableview有偏移距离时,无法响应pan
        if (y > 0 || self.tableView.isDragging == TRUE) {
            return FALSE;
        }
    }
    return TRUE;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        CGPoint vel = [self.tableView.panGestureRecognizer velocityInView:self.tableView];
        if (vel.y > 0.0f) { // 往下移动
            return FALSE;
        }
        
//        // 往右滑动
//        if (vel.x > 0.0f) {
//            return FALSE;
//        }
    }
    return TRUE;
}

- (BOOL)isTableViewHeaderExist {
    return FALSE;
}

- (UIEdgeInsets)tableViewContentInsets {
    return UIEdgeInsetsMake([self heightForNavigationBar], 0, [UIDevice safeAreaBottom], 0);
}

- (void)configureNavigationBackBarButtonWithContainer:(YYBNavigationBarControl *)container {
    container.style = YYBNavigationBarControlStyleLeft;
    
    container.contentEdgeInsets = UIEdgeInsetsMake([self topOffset], 16.0f, 0, 0);
    container.imageSize = CGSizeMake(25.0f, 25.0f);
    
    UIImage *icon = [NSBundle imageWithBundleName:@"Icon_Overlay" imageName:@"ic_gesoverlay_close"];
    [container setBarButtonImage:icon controlState:0];
}

- (BOOL)navigationBackBarButtonHandler {
    _transition.pan = nil;
    [self dismissViewControllerAnimated:TRUE completion:nil];
    return FALSE;
}

- (CGFloat)contentRadius {
    return 12.0f;
}

- (void)configureNavigationView {
    [super configureNavigationView];
    self.navigationBar.bottomLayerView.backgroundColor = [UIColor colorWithHexInteger:0xF6F6F6];
}

- (UIColor *)navigationBarBackgroundColor {
    return [UIColor whiteColor];
}

- (CGFloat)heightForNavigationBar {
    return 60.0f;
}

- (CGFloat)topOffset {
    return 0.0f;
}

- (void)recognizerUpdate:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            _transition.pan = pan;
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
            break;
        default:
            break;
    }
}

@end
