//
//  LYHomePageService.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//  主页--请求服务

#import <Foundation/Foundation.h>

@protocol LYHomePageService <NSObject>

@optional
// 加载首页数据
- (RACSignal *)requestActivityDataSignal:(NSString *)requestUrl;

// 加载首页更多数据
- (RACSignal *)requestActivityMoreDataSignal:(NSString *)requestUrl;

@end
