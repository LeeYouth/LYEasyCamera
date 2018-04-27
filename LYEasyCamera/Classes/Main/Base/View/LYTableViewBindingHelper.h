//
//  LYTableViewBindingHelper.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYViewModel;

@interface LYTableViewBindingHelper : NSObject

@property (weak, nonatomic) id<UITableViewDelegate> delegate;

/**
 代码创建cell时调用
 
 @param tableView tableview
 @param source 数据信号
 @param didSelectionCommand cell选中信号
 @param templateCell cell的类名
 @param viewModel viewModel
 @return 配置好的tableview
 */
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)didSelectionCommand
                              templateCell:(NSString *)templateCell
                             withViewModel:(LYViewModel *)viewModel;
/**
 xib创建cell时调用
 
 @param tableView tableview
 @param source 数据信号
 @param didSelectionCommand cell选中信号
 @param templateCell Nib的类名
 @param viewModel viewModel
 @return 配置好的tableview
 */
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)didSelectionCommand
                       templateCellWithNib:(NSString *)templateCell
                             withViewModel:(LYViewModel *)viewModel;

@end
