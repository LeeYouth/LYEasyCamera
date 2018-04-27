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
- (id<LYViewModelProtocolImpl>)getActivityService
{
    return self.homePageService;
}
- (id<LYViewModelProtocolImpl>)getActivityDetailService
{
    return self.homePageDetailService;
}
- (id<LYViewModelProtocolImpl>)getMovieService
{
    return self.movieService;
}
- (id<LYViewModelProtocolImpl>)getMovieDetailService
{
    return self.movieDetailService;
}

- (id<LYViewModelProtocolImpl>)getSettingService
{
    return self.settingService;
}


@end
