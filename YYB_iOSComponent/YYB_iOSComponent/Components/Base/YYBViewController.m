//
//  YYBViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/7/4.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBViewController.h"
#import "NSBundle+YYBAdd.h"

@interface YYBViewController ()

@end

@implementation YYBViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    YYBViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController);
         [viewController renderDefaultViews];
     }];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = TRUE;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearanceWhenContainedInInstancesOfClasses:@[self.class]].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _isPreferNavigationBarHidden = NO;
    _isPreferBackNavigationButtonHidden = NO;
}

- (void)renderDefaultViews {
    if (!_isPreferNavigationBarHidden) {
        _navigationBar = [[YYBNavigationBar alloc] init];
        _navigationBar.backgroundColor = [self navigationBarBackgroundColor];
        
        CGRect frame = [self frameForNavigarionBar];
        if (CGRectEqualToRect(CGRectZero, frame)) {
            _navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [self heightForNavigationBar]);
        } else {
            _navigationBar.frame = frame;
        }
        
        [self configureNavigationTitleBarButtonWithContainer:_navigationBar.titleBarButton];
        [self.view addSubview:_navigationBar];
        
        if (!_isPreferBackNavigationButtonHidden) {
            @weakify(self);
            _navigationBackBarButton = [YYBNavigationBarContainer controlWithConfigureHandler:^(YYBNavigationBarControl *container, UIImageView *iconView, UILabel *label) {
                @strongify(self);
                [self configureNavigationBackBarButtonWithContainer:container];
            } tapedActionHandler:^(YYBNavigationBarContainer *view) {
                @strongify(self);
                if ([self navigationBackBarButtonHandler] == TRUE) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            
            _navigationBar.leftBarContainers = @[_navigationBackBarButton];
        }
    }
    
    NSString *title = [self titleForNavigationBar];
    if (title && title.length > 0) {
        _navigationBar.titleBarButton.label.text = title;
    }
    
    [self configureNavigationView];
}

- (CGFloat)topOffset {
    return [UIDevice iPhoneXSeries] ? 20.0f : 10.0f;
}

- (CGFloat)heightForNavigationBar {
    return 44.0 + [UIDevice safeAreaTop];
}

- (CGRect)frameForNavigarionBar {
    return CGRectZero;
}

- (UIColor *)navigationBarBackgroundColor {
    return [UIColor colorWithHexInteger:0xF7F7F7];
}

- (void)configureNavigationBackBarButtonWithContainer:(YYBNavigationBarControl *)container {
    container.style = YYBNavigationBarControlStyleLeft;
    
    container.contentEdgeInsets = UIEdgeInsetsMake([self topOffset], 16.0f, 0, 0);
    container.iconEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.0f);
    container.imageSize = CGSizeMake(10.0f, 18.0f);
    
    [container setBarButtonTextColor:[UIColor colorWithHexInteger:0x69B2FD] controlState:0];
    [container setBarButtonTitle:@"返回" controlState:0];
    [container setBarButtonTextFont:[UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold] controlState:0];
    [container setBarButtonTextFont:[UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold] controlState:UIControlStateHighlighted];
    
    [container setBarButtonImage:[self defaultBackNavigationBarButtonImage] controlState:0];
}

- (UIImage *)defaultBackNavigationBarButtonImage {
    return [NSBundle imageWithBundleName:@"Icon_Base" imageName:@"ic_navigation_icon_normal"];
}

- (void)configureNavigationTitleBarButtonWithContainer:(YYBNavigationBarLabel *)container {
    container.label.textColor = [UIColor blackColor];
    container.contentEdgeInsets = UIEdgeInsetsMake([self topOffset], 0, 0, 0);
    container.label.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
}

- (void)configureNavigationView {
    
}

- (NSString *)titleForNavigationBar {
    return @"";
}

- (BOOL)navigationBackBarButtonHandler {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)hidesBottomBarWhenPushed {
    return TRUE;
}

- (void)dealloc {
    NSLog(@"dealloc - %@",NSStringFromClass([self class]));
}

@end
