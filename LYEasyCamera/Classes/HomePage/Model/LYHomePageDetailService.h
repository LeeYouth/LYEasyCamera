//
//  LYHomePageDetailService.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//  主页详情页--请求服务

#import <Foundation/Foundation.h>

@protocol LYHomePageDetailService <NSObject>

@optional
// 加载首页详情数据
- (RACSignal *)requestHomePageDetailDataSignal:(NSString *)requestUrl;

@end
