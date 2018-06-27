//
//  LYConstant.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//  一些常量

#import <Foundation/Foundation.h>

@interface LYConstant : NSObject


////////////////// MVVM ViewModel Params中的key //////////////////
/// MVVM View
/// The base map of 'params'
/// The `params` parameter in `-initWithParams:` method.
/// Key-Values's key
/// 传递唯一ID的key：例如：商品id 用户id...
FOUNDATION_EXTERN NSString *const LYViewModelIDKey;
/// 传递导航栏title的key：例如 导航栏的title...
FOUNDATION_EXTERN NSString *const LYViewModelTitleKey;
/// 传递导航栏title的key：例如 导航栏的title...
FOUNDATION_EXTERN NSString *const LYViewModelTitleKey;
/// 传递导航栏类型
FOUNDATION_EXTERN NSString *const LYViewModelNavTpeKey;
/// 传递数据模型的key：例如 商品模型的传递 用户模型的传递...
FOUNDATION_EXTERN NSString *const LYViewModelUtilKey;
/// 传递webView Request的key：例如 webView request...
FOUNDATION_EXTERN NSString *const LYViewModelRequestKey;

@end
