//
//  LYHomePageViewController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYHomePageViewModel.h"

@interface LYHomePageViewController ()

/** bind ViewModel */
@property (strong, nonatomic, readonly) LYHomePageViewModel *viewModel;

@end

@implementation LYHomePageViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - bind
- (void)bindViewModel
{
    [super bindViewModel];
    
    [self.viewModel.requestDataCommand execute:@1];

}

@end
