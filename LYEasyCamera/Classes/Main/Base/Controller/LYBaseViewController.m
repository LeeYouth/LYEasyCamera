//
//  LYBaseViewController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYViewModel.h"

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


@end
