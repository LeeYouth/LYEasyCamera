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
    
    NSString *url = @"/v2/event/list?start=0&loc=beijing&count=10&type=music";
    
    @weakify(self);
    _activityMoreDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        return [[[self.services getActivityService] requestActivityDataSignal:url] doNext:^(id  _Nullable result) {
            
            self.activityData = result;
            
        }];
    }];
    
    _activityDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        return [RACSignal empty];
    }];
    
    _activityMoreConnectionErrors = _activityMoreDataCommand.errors;
}
- (RACSignal *)executeRequestDataSignal:(id)input
{
    if ([input integerValue] == RealStatusNotReachable) {
        
        return [RACSignal empty];
        
    }else{
        NSString *url = @"/v2/event/list?start=0&loc=beijing&count=10&type=music";

        @weakify(self);
        return [[[self.services getActivityService] requestActivityDataSignal:url] doNext:^(id  _Nullable result) {
            @strongify(self);

            self.activityData = result;

        }];
    }
}
@end
