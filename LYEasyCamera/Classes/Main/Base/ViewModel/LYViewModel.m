//
//  LYViewModel.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/12.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYViewModel.h"

@interface LYViewModel()

@property (nonatomic, readwrite, copy) NSDictionary *params;
@property (strong, nonatomic, readwrite) id<LYViewModelService> services;
@property (strong, nonatomic, readwrite) RACCommand *requestDataCommand;
@property (assign, nonatomic, readwrite) LYNavBarStyleType navBarStyleType;
@property (copy, nonatomic, readwrite) NSString *title;

@end

@implementation LYViewModel

- (instancetype)initWithServices:(id<LYViewModelService>)services params:(NSDictionary *)params
{
    
    if (self = [super init]) {
        
        self.services = services;
        self.params = params;
        self.navBarStyleType = [params[LYViewModelNavTpeKey] integerValue];
        self.title = params[LYViewModelTitleKey];
        @weakify(self);
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            //这里这样写只是为了给大家开拓一种思路,selector的方法可以应需求更改,即当这个方法执行后,产生一个信号告知控制器释放掉这个订阅的信号
            return [[self executeRequestDataSignal:input] takeUntil:self.rac_willDeallocSignal];
        }];
        
        [self initialize];
    }
    return self;
}

- (void)initialize{}

- (RACSignal *)executeRequestDataSignal:(id)input
{
    return [RACSignal empty];
}

@end
