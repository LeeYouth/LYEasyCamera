//
//  LYMediatorAction+LYHomePageDetailViewController.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//  跳转详情页

#import "LYMediatorAction.h"
@class LYHomePageDetailViewModel;

@interface LYMediatorAction (LYHomePageDetailViewController)

- (void)pushHomePageDetailViewControllerWithViewModel:(LYHomePageDetailViewModel *)viewModel;

@end
