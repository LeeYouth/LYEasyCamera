//
//  LYConstant.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYConstant.h"

@implementation LYConstant

////////////////// MVVM ViewModel Params中的key //////////////////
/// MVVM View
/// The base map of 'params'
/// The `params` parameter in `-initWithParams:` method.
/// Key-Values's key
/// 传递唯一ID的key：例如：商品id 用户id...
NSString *const LYViewModelIDKey = @"LYViewModelIDKey";
/// 传递导航栏title的key：例如 导航栏的title...
NSString *const LYViewModelTitleKey = @"LYViewModelTitleKey";
/// 传递导航栏类型
NSString *const LYViewModelNavTpeKey = @"LYViewModelNavTpeKey";
/// 传递数据模型的key：例如 商品模型的传递 用户模型的传递...
NSString *const LYViewModelUtilKey = @"LYViewModelUtilKey";
/// 传递webView Request的key：例如 webView request...
NSString *const LYViewModelRequestKey = @"LYViewModelRequestKey";


@end
