//
//  YYBViewController.m
//  SavingPot365
//
//  Created by Aokura on 2018/7/4.
//  Copyright © 2018年 Tree,Inc. All rights reserved.
//

#import "YYBViewController.h"

@interface YYBViewController ()

@end

@implementation YYBViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    YYBViewController *viewController = [super allocWithZone:zone];
    
    __weak typeof(viewController) weak_vc =  viewController;
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         __strong typeof(viewController) strong_vc = weak_vc;
         [strong_vc renderDefaultViews];
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

- (void)configureDefaultProps {
    
}

- (void)renderDefaultViews {
    if (!_isPreferNavigationBarHidden) {
        _navigationBar = [[YYBNavigationBar alloc] init];
        _navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [self heightForNavigationBar]);
        _navigationBar.backgroundColor = [UIColor colorWithHexInteger:0xF6F6F6];
        [self.view addSubview:_navigationBar];
        
        if (!_isPreferBackNavigationButtonHidden) {
            @weakify(self);
            _navigationBackBarButton = [YYBNavigationBarContainer controlWithConfigureHandler:^(YYBNavigationBarControl *container, UIImageView *iconView, UILabel *label) {
                container.style = YYBNavigationBarControlStyleLeft;
                
                container.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 16.0f, 0, 0);
                container.iconEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.0f);
                container.imageSize = CGSizeMake(9.0f, 17.0f);
                
                [container setBarButtonTitle:@"返回" controlState:0];
                [container setBarButtonTextFont:[UIFont systemFontOfSize:16.0f] controlState:0];
                [container setBarButtonTextFont:[UIFont systemFontOfSize:16.0f] controlState:UIControlStateHighlighted];
                [container setBarButtonImage:[UIImage imageNamed:@"ic_yyb_navigation_back_black"] controlState:0];
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
    if ([title isExist]) {
        self.navigationBar.titleBarButton.label.text = title;
        self.navigationBar.titleBarButton.label.textColor = [UIColor blackColor];
        self.navigationBar.titleBarButton.contentEdgeInsets = UIEdgeInsetsMake([UIDevice iPhoneXSeries] ? 20.0f : 10.0f, 0, 0, 0);
        self.navigationBar.titleBarButton.label.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
    }
    
    [self configureNavigationView];
}

- (CGFloat)heightForNavigationBar {
    return 64.0 + [UIDevice safeAreaTop];
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

- (void)dealloc {
    NSLog(@"dealloc - %@",NSStringFromClass([self class]));
}

@end
