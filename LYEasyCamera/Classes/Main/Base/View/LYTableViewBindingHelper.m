//
//  LYTableViewBindingHelper.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYTableViewBindingHelper.h"
#import "LYViewModel.h"
#import "LYReactiveView.h"

@interface LYTableViewBindingHelper()<UITableViewDelegate,UITableViewDataSource>

/**
 *  tableView
 */
@property (strong, nonatomic) UITableView *tableView;
/**
 *  数据源
 */
@property (strong, nonatomic) NSArray *data;
/**
 *  selection
 */
@property (strong, nonatomic) RACCommand *didSelectionCommand;
/**
 *  cell重用标识
 */
@property (copy, nonatomic) NSString *cellIdentifier;
/**
 *  viewModel
 */
@property (strong, nonatomic) LYViewModel  *viewModel;

@end

@implementation LYTableViewBindingHelper

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand templateCell:(NSString *)templateCell  withViewModel:(LYViewModel *)viewModel
{
    NSDictionary *cellDic = @{@"cellType":@"codeType",@"cellName":templateCell};
    return [[LYTableViewBindingHelper alloc] initWithTableView:tableView
                                                  sourceSignal:source
                                              selectionCommand:didSelectionCommand
                                                  withCellType:cellDic
                                                 withViewModel:viewModel];
}
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand templateCellWithNib:(NSString *)templateCell withViewModel:(LYViewModel *)viewModel
{
    NSDictionary *cellDic = @{@"cellType":@"nibType",@"cellName":templateCell};
    return [[LYTableViewBindingHelper alloc] initWithTableView:tableView
                                                  sourceSignal:source
                                              selectionCommand:didSelectionCommand
                                                  withCellType:cellDic
                                                 withViewModel:viewModel];
}
#pragma mark - init
- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand withCellType:(NSDictionary *)CellTypeDic withViewModel:(LYViewModel *)viewModel
{
    if (self = [super init]) {
        
        _tableView = tableView;
        _data = [NSArray array];
        _didSelectionCommand = didSelectionCommand;
        _viewModel = viewModel;
        
        @weakify(self);
        [source subscribeNext:^(id x) {
            @strongify(self);
            self.data = x;
            [self.tableView reloadData];
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;

        
        NSString *cellType = CellTypeDic[@"cellType"];
        _cellIdentifier = CellTypeDic[@"cellName"];
        if ([cellType isEqualToString:@"codeType"]) {
            
            Class cell =  NSClassFromString(_cellIdentifier);
            [_tableView registerClass:cell forCellReuseIdentifier:_cellIdentifier];
            
        }else{
            
            UINib *templateCellNib = [UINib nibWithNibName:_cellIdentifier bundle:nil];
            [_tableView registerNib:templateCellNib forCellReuseIdentifier:_cellIdentifier];
        }
        
    }
    return self;
}
- (void)dealloc
{
    self.delegate = nil;
}
#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.data.count == 0) ? YES : NO;
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<LYReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    [cell bindViewModel:self.viewModel withParams:@{DataIndex:@(indexPath.row)}];
    return (UITableViewCell *)cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.didSelectionCommand execute:self.data[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
