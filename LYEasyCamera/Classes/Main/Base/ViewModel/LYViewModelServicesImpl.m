//
//  LYViewModelServicesImpl.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYViewModelServicesImpl.h"
#import "LYHomePageProtocolImpl.h"
#import "LYHomePageDetailProtocolImpl.h"
#import "LYMovieProtocolImpl.h"
#import "LYMovieDetailProtocolImpl.h"
#import "LYSettingProtocolImpl.h"
#import "LYSettingViewModel.h"


@interface LYViewModelServicesImpl ()
/** 首页数据服务 */
@property (strong, nonatomic) LYHomePageProtocolImpl *homePageService;
/** 首页详情数据服务 */
@property (strong, nonatomic) LYHomePageDetailProtocolImpl *homePageDetailService;

/** 电影数据服务 */
@property (strong, nonatomic) LYMovieProtocolImpl *movieService;
/** 电影详情数据服务 */
@property (strong, nonatomic) LYMovieDetailProtocolImpl *movieDetailService;

/** 设置数据服务 */
@property (strong, nonatomic) LYSettingProtocolImpl *settingService;

@end

@implementation LYViewModelServicesImpl

- (instancetype)initModelServiceImpl
{
    if (self = [super init]) {
        
        _homePageService       = [LYHomePageProtocolImpl new];
        _homePageDetailService = [LYHomePageDetailProtocolImpl new];
        _movieService          = [LYMovieProtocolImpl new];
        _movieDetailService    = [LYMovieDetailProtocolImpl new];
        
    }
    return self;
}
- (id<LYHomePageService>)getHomePageService
{
    return self.homePageService;
}

- (id<LYHomePageDetailService>)getHomePageDetailService
{
    return self.homePageDetailService;
}


- (id<LYMovieService>)getMoviesService
{
    return self.movieService;
}
- (id<LYMovieDetailService>)getMoviesDetailService
{
    return self.movieDetailService;
}

- (id<LYSettingService>)getSettingService
{
    return self.settingService;
}


@end
