//
//  LYViewModelService.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYViewModelProtocolImpl.h"


@protocol LYViewModelService <NSObject>

// 获取首页活动服务
- (id<LYViewModelProtocolImpl>) getActivityService;
// 获取活动详情页详情服务
- (id<LYViewModelProtocolImpl>) getActivityDetailService;

// 获取电影服务
- (id<LYViewModelProtocolImpl>) getMovieService;
// 获取活动详情页详情服务
- (id<LYViewModelProtocolImpl>) getMovieDetailService;

// 获得web服务
- (id<LYViewModelProtocolImpl>) getWebService;

@end
