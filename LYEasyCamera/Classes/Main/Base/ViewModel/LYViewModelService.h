//
//  LYViewModelService.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYHomePageService.h"
#import "LYHomePageDetailService.h"
#import "LYMovieService.h"
#import "LYMovieDetailService.h"
#import "LYsettingService.h"

@protocol LYViewModelService <NSObject>

// 获取首页活动服务
- (id<LYHomePageService>) getHomePageService;
// 获取活动详情页详情服务
- (id<LYHomePageDetailService>) getHomePageDetailService;

// 获取电影服务
- (id<LYMovieService>) getMoviesService;
// 获取活动详情页详情服务
- (id<LYMovieDetailService>) getMoviesDetailService;

// 获得设置服务
- (id<LYSettingService>) getSettingService;

@end
