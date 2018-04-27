//
//  LYHomePageViewModel.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYViewModel.h"

@interface LYHomePageViewModel : LYViewModel
/**
 *  错误信号
 */
@property (strong, nonatomic) RACSignal *activityConnectionErrors;
/**
 *  更多数据请求
 */
@property (strong, nonatomic) RACCommand *activityMoreDataCommand;
/**
 *  更多错误信号
 */
@property (strong, nonatomic) RACSignal *activityMoreConnectionErrors;
/**
 *  活动详情
 */
@property (strong, nonatomic) RACCommand *activityDetailCommand;
/**
 *  活动数据
 */
@property (strong, nonatomic) NSArray *activityData;

@end
