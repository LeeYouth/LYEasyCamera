//
//  LYBaseViewController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYViewModel.h"
#import "UIViewController+LYHideShadowLine.h"

@interface LYBaseViewController ()
@property (strong, nonatomic, readwrite) LYViewModel *viewModel;
@end

@implementation LYBaseViewController

- (instancetype)initWithViewModel:(LYViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
}
- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(LY_APPDelegate , NetWorkStatus) subscribeNext:^(NSNumber *networkStatus) {
        
        @strongify(self);
        if (networkStatus.integerValue == RealStatusNotReachable || networkStatus.integerValue == RealStatusUnknown) {
            
            [self.viewModel.requestDataCommand execute:@(RealStatusNotReachable)];
        }else{
            
            [self.viewModel.requestDataCommand execute:@1];
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    [self removeFakeNavBar];
    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self LY_hideShadowLineInView:self.navigationController.navigationBar];
        
        [self addFakeNavBar];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self removeFakeNavBar];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeFakeNavBar];
    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
        [self addFakeNavBar];
        self.navigationController.navigationBar.barStyle = UINavigationBar.appearance.barStyle;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        [self LY_showShadowLineInView:self.navigationController.navigationBar];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self removeFakeNavBar];
}
- (void)addFakeNavBar {
    
    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
        [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self LY_hideShadowLineInView:self.navBar];
        
    }else {
        [self.navBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        [self LY_showShadowLineInView:self.navBar];
        
    }
}

- (void)removeFakeNavBar {
    if (self.navBar.superview) {
        [self.navBar removeFromSuperview];
    }
}
- (UINavigationBar *)navBar
{
    return LY_LAZY(_navBar, ({
        
        UINavigationBar *bar = [[UINavigationBar alloc] init];
        bar.barStyle = UINavigationBar.appearance.barStyle;
        bar.translucent = YES;
        [self.view addSubview:bar];
        [bar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVBAR_HEIGHT)];
        bar;
    }));
}
+ (void)popCallBack:(NSDictionary *)infoDic{};


@end
