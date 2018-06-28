//
//  LYMediatorAction.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYMediatorAction.h"
#import "VKURLAction.h"

@implementation LYMediatorAction

#pragma mark - Public Methods
+ (instancetype)sharedInstance
{
    static LYMediatorAction *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[LYMediatorAction alloc] init];
    });
    return mediator;
}

- (void)performActionWithUrl:(NSString *)url animated:(BOOL)animated
{
    id vc = [[VKURLAction sharedInstance] doActionWithUrlString:url];
    UIViewController *currentVC = [self currentViewController];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [currentVC.navigationController pushViewController:vc animated:animated];
    }
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName
{
    /*
     这里只返回当前控制器，具体的route由相应的分类实现
     */
    UIViewController *currentVC = [self currentViewController];
    
    return currentVC;
}
#pragma mark - Private Methods
// 获取当前控制器
-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
@end
