//
//  LYViewModelProtocolImpl.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYViewModelProtocolImpl <NSObject>

@optional
// 加载首页数据
- (RACSignal *)requestActivityDataSignal:(NSString *)requestUrl;

// 加载首页更多数据
- (RACSignal *)requestActivityMoreDataSignal:(NSString *)requestUrl;

// 加载首页详情数据
- (RACSignal *)requestActivityDetailDataSignal:(NSString *)requestUrl;

@end
