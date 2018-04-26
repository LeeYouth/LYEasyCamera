//
//  LYConfigBaseNavigationController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYConfigBaseNavigationController.h"

@interface LYConfigBaseNavigationController ()

@end

@implementation LYConfigBaseNavigationController

#pragma mark - Life CyCle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self setUpNavigationBarAppearance];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
//        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = CGRectGetWidth([UIScreen mainScreen].bounds)/3;
//        [self setUpCustomNavigationBarWithViewController:viewController];
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark - 设置全局的导航栏属性
- (void)setUpNavigationBarAppearance
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = @{NSFontAttributeName:LYFont(@"Noteworthy-Bold", 18),
                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                     };
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.barTintColor = LYColorWithHexStr(@"#dedede");
}
//- (void)setUpCustomNavigationBarWithViewController:(UIViewController *)viewController
//{
//    UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"icon_nav_back_white_19x18_"  selectImage:@"icon_nav_back_white_19x18_"];
//    viewController.navigationItem.leftBarButtonItem = item;
//}
//- (void)btnLeftBtn
//{
//    [self popViewControllerAnimated:YES];
//}
#pragma mark - UIStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
