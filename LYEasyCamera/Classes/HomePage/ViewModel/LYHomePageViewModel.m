//
//  LYHomePageViewModel.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYHomePageViewModel.h"

@interface LYHomePageViewModel ()

@end

@implementation LYHomePageViewModel

- (instancetype)initWithServices:(id<LYViewModelService>)services params:(NSDictionary *)params
{
    if (self = [super initWithServices:services params:params]) {

        _activityData = [NSArray new];
    }
    return self;
}
- (void)initialize
{
    [super initialize];
    
    //加载更多
    @weakify(self);
    _activityMoreDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);

        NSString *requestURL = [NSString stringWithFormat:@"%@?start=%lu&loc=beijing&count=10&type=music",LYURL_HOMEPAGE_ACTIVITYLIST,self.activityData.count];

        return [[[self.services getHomePageService] requestActivityMoreDataSignal:requestURL] doNext:^(id  _Nullable result) {
            
            self.activityData = result;
            
        }];
    }];
    
    _activityDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];

    _activityMoreConnectionErrors = _activityMoreDataCommand.errors;
}
- (RACSignal *)executeRequestDataSignal:(id)input
{
    if ([input integerValue] == RealStatusNotReachable) {

        return [RACSignal empty];

    }else{

        NSString *requestURL = [NSString stringWithFormat:@"%@?start=0&loc=beijing&count=10&type=music",LYURL_HOMEPAGE_ACTIVITYLIST];
        //首次加载
        @weakify(self);
        return [[[self.services getHomePageService] requestActivityDataSignal:requestURL] doNext:^(id  _Nullable result) {
            @strongify(self);

            self.activityData = result;

        }];
    }
}
@end
