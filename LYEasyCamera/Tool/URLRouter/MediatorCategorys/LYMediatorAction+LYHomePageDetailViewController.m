//
//  LYMediatorAction+LYHomePageDetailViewController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYMediatorAction+LYHomePageDetailViewController.h"

@implementation LYMediatorAction (LYHomePageDetailViewController)

- (void)pushHomePageDetailViewControllerWithViewModel:(LYHomePageDetailViewModel *)viewModel
{
    id vc = [@"LYHomePageDetailViewController" VKCallClassAllocInitSelectorName:@"initWithViewModel:" error:nil,viewModel];
    UIViewController *currentVC = [self performTarget:nil action:nil];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        [currentVC.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
