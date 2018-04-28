//
//  LYHomePageViewController.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYHomePageViewModel.h"
#import "LYBaseTableView.h"
#import "LYTableViewBindingHelper.h"

@interface LYHomePageViewController ()<UITableViewDelegate>

/** bind ViewModel */
@property (strong, nonatomic, readonly) LYHomePageViewModel *viewModel;

/** tableview  */
@property (strong, nonatomic) LYBaseTableView *tableView;
/** bind tableview */
@property (strong, nonatomic) LYTableViewBindingHelper *bindingHelper;

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
    
    self.bindingHelper = [LYTableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:RACObserve(self.viewModel, activityData) selectionCommand:self.viewModel.activityDetailCommand templateCell:@"LYActivityTableViewCell" withViewModel:self.viewModel];
    self.bindingHelper.delegate = self;
    
    //下拉刷新
    @weakify(self);
    self.tableView.mj_header =  [LYCustomRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.requestDataCommand execute:@1];
    }];

    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable executing) {
        @strongify(self);
        if (!executing.boolValue) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
    //加载更多
    self.tableView.mj_footer = [LYCustomRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.activityMoreDataCommand execute:@1];
    }];
    [[self.viewModel.activityMoreDataCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable executing) {
        @strongify(self);
        if (!executing.boolValue) {
            [self.tableView.mj_footer endRefreshing];
        }
    }];

}

- (LYBaseTableView *)tableView
{
    return LY_LAZY(_tableView, ({
        
        LYBaseTableView *tableView = [[LYBaseTableView alloc] initWithFrame:self.view.bounds];
        tableView.rowHeight = 120 + 2*LYStatusCellMargin;
        [self.view addSubview:tableView];
        tableView;
    }));
}
@end
