//
//  LYHomePageProtocolImpl.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYHomePageProtocolImpl.h"
#import "LYActivityItemModel.h"

@interface LYHomePageProtocolImpl()

/** item数组 */
@property (strong, nonatomic) NSMutableArray *resultArray;

@end

@implementation LYHomePageProtocolImpl

- (RACSignal *)requestActivityDataSignal:(NSString *)requestUrl{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        @strongify(self);
        NSURLSessionTask *task = [LYNetworkHelper getWithUrl:requestUrl parameters:nil showHUD:NO success:^(id responseObject) {
            
            NSArray *resArray = responseObject[@"events"];

            [self.resultArray removeAllObjects];
            [resArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                LYActivityItemModel *model = [LYActivityItemModel yy_modelWithJSON:obj];
                [self.resultArray addObject:model];
                
            }];
            
            [subscriber sendNext:self.resultArray];
            [subscriber sendCompleted];
            
        } failure:^(NSError *error) {
            
            [subscriber sendError:error];

        }];
        
        return [RACDisposable disposableWithBlock:^{
            
            [task cancel];
        }];
    }];
    
}
#pragma mark - getter
- (NSMutableArray *)resultArray
{
    return LY_LAZY(_resultArray, @[].mutableCopy);
}
@end
