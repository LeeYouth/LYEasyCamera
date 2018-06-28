//
//  LYViewModel.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/12.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LYViewModelService.h"


typedef NS_ENUM(NSUInteger, LYNavBarStyleType) {
    
    kNavBarStyleNomal   = 0, // 默认
    kNavBarStyleHidden  = 1, // 隐藏
    
};

@interface LYViewModel : NSObject
/** 数据请求 */
@property (strong, nonatomic, readonly) RACCommand *requestDataCommand;
/** NavBar类型 */
@property (assign, nonatomic, readonly) LYNavBarStyleType navBarStyleType;
/** 标题 */
@property (copy, nonatomic, readonly) NSString *title;
/** The `params` parameter in `-initWithParams:` method. */
@property (copy, nonatomic, readonly) NSDictionary *params;
/** viewModel服务 */
@property (strong, nonatomic, readonly) id<LYViewModelService> services;

/**
 初始化方法。这是创建新视图模型的首选方式。
 @param services 实现代理。
 @param params 要传递给视图模型的参数。
 */
- (instancetype)initWithServices:(id<LYViewModelService>)services params:(NSDictionary *)params;

- (void)initialize;

- (RACSignal *)executeRequestDataSignal:(id)input;


@end
