//
//  LYTabBarControllerConfig.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYTabBarControllerConfig.h"
#import "LYHomePageViewController.h"
#import "LYMovieViewController.h"
#import "LYSettingViewController.h"

#import "LYHomePageViewModel.h"
#import "LYMovieViewModel.h"
#import "LYSettingViewModel.h"

#import "LYConfigBaseNavigationController.h"
#import "LYViewModelServicesImpl.h"

@interface LYTabBarControllerConfig ()

/**  数据服务 */
@property (strong, nonatomic) LYViewModelServicesImpl *viewModelService;
/** 首页viewModel */
@property (strong, nonatomic) LYHomePageViewModel *homePageViewModel;
/** 电影viewModel */
@property (strong, nonatomic) LYMovieViewModel *movieViewModel;
/** 设置viewModel */
@property (strong, nonatomic) LYSettingViewModel *settingViewModel;

@end

@implementation LYTabBarControllerConfig

- (LYTabBarController *)tabBarController
{
    return LY_LAZY(_tabBarController, ({
        LYTabBarController *tabBarVC = [[LYTabBarController alloc] init];
        tabBarVC.viewControllers = [self viewControllersForController];
        [self tabBarAppearanceConfig:tabBarVC];
        tabBarVC;
    }));
}

- (NSArray *)viewControllersForController {
    
    NSArray *normal = @[@"tabbar_discover", @"tabbar_mainframe", @"tabbar_contacts",@"tabbar_me"];
    NSArray *selected = @[@"tabbar_discoverHL", @"tabbar_mainframeHL", @"tabbar_contactsHL",@"tabbar_meHL"];
    // 数据服务
    self.viewModelService = [[LYViewModelServicesImpl alloc] initModelServiceImpl];
    
    // 首页
    self.homePageViewModel = [[LYHomePageViewModel alloc] initWithServices:self.viewModelService params:nil];
    
    LYHomePageViewController *homePageVC = [[LYHomePageViewController alloc] initWithViewModel:self.homePageViewModel];
    LYConfigBaseNavigationController *homePageNav = [self addChildViewController:homePageVC title:@"推荐" image:normal[0] selectedImage:selected[0]];
    
    // 电影
    self.movieViewModel = [[LYMovieViewModel alloc] initWithServices:self.viewModelService params:nil];
    
    LYMovieViewController *movieVC = [[LYMovieViewController alloc] initWithViewModel:self.movieViewModel];
    LYConfigBaseNavigationController *movieNav = [self addChildViewController:movieVC title:@"电影" image:normal[1] selectedImage:selected[1]];
    
    // 设置
    self.settingViewModel = [[LYSettingViewModel alloc] initWithServices:self.viewModelService params:nil];
    
    LYSettingViewController *settingVC = [[LYSettingViewController alloc] initWithViewModel:self.settingViewModel];
    LYConfigBaseNavigationController *settingNav = [self addChildViewController:settingVC title:@"设置" image:normal[2] selectedImage:selected[2]];
    
    
    NSArray *viewControllers = @[
                                 homePageNav,
                                 movieNav,
                                 settingNav,
                                 ];
    return viewControllers;
}

- (void)tabBarAppearanceConfig:(LYTabBarController *)tabBarVC
{
    
}

/**
 *  设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (LYConfigBaseNavigationController *)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{

    //1.tababr标题
    childController.tabBarItem.title = title;
    UIImage *normal = [UIImage imageNamed:image];
    UIImage *selected = [UIImage imageNamed:selectedImage];
    
    childController.tabBarItem.image = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //2.包装导航控制器
    childController.title = title;
    LYConfigBaseNavigationController *nav = [[LYConfigBaseNavigationController alloc]
                                                    initWithRootViewController:childController];
    return nav;
}

@end
