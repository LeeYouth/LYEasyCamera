//
//  LYNetworkHelper.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFSecurityPolicy.h"
#import "MTToast.h"
#import "AFHTTPSessionManager.h"

@class LYFileData;

/*!
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^LYUploadProgress)(int64_t bytesRead,
                                   int64_t totalBytesRead);

typedef LYUploadProgress LYGetProgress;
typedef LYUploadProgress LYPostProgress;

typedef NS_ENUM(NSUInteger, LYNetworkStatus) {
    /** 未知网络*/
    LYNetworkStatusUnknown,
    /** 无网络*/
    LYNetworkStatusNotReachable,
    /** 手机网络*/
    LYNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    LYNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, LYRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    LYRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    LYRequestSerializerHTTP,
};
typedef NS_ENUM(NSUInteger, LYResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    LYResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    LYResponseSerializerHTTP,
};

/** 网络状态的Block*/
typedef void(^NetworkState)(LYNetworkStatus status);


/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);


@interface LYNetworkHelper : NSObject


/**
 实时监控当前网络的状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(NetworkState)networkStatus;

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/*!
 *
 *
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;


/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;

/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/**
 *  GET请求,无缓存,有进度条
 *
 *  @param Url        请求地址
 *  @param parameters 请求参数
 *  @param showHUD    是否显示HUD
 *  @param progress   进度条
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)getWithUrl:(NSString *)Url
                               parameters:(NSDictionary *)parameters
                                  showHUD:(BOOL)showHUD
                                 progress:(LYUploadProgress)progress
                                  success:(HttpRequestSuccess)success
                                  failure:(HttpRequestFailed)failure;
/**
 *  GET请求,无缓存,无进度条
 *
 *  @param Url        请求地址
 *  @param parameters 请求参数
 *  @param showHUD    是否显示HUD
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)getWithUrl:(NSString *)Url
                               parameters:(NSDictionary *)parameters
                                  showHUD:(BOOL)showHUD
                                  success:(HttpRequestSuccess)success
                                  failure:(HttpRequestFailed)failure;

/**
 *  POST请求,无缓存,有进度条
 *
 *  @param Url        请求地址
 *  @param parameters 请求参数
 *  @param showHUD    是否显示HUD
 *  @param progress   进度条
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)postWithUrl:(NSString *)Url
                                parameters:(NSDictionary *)parameters
                                   showHUD:(BOOL)showHUD
                                  progress:(LYUploadProgress)progress
                                   success:(HttpRequestSuccess)success
                                   failure:(HttpRequestFailed)failure;

/**
 *  POST请求,无缓存,无进度条
 *
 *  @param Url        请求地址
 *  @param parameters 请求参数
 *  @param showHUD    是否显示HUD
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)postWithUrl:(NSString *)Url
                                parameters:(NSDictionary *)parameters
                                   showHUD:(BOOL)showHUD
                                   success:(HttpRequestSuccess)success
                                   failure:(HttpRequestFailed)failure;


/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param files      文件数组
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                              files:(NSArray *)files
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(HttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(HttpRequestFailed)failure;

/*
 **************************************  设置  **********************************************
 */
#pragma mark - 重置AFHTTPSessionManager相关属性
/**
 *  设置网络请求参数的格式:默认为JSON格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(LYRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(LYResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;



@end



@interface LYFileData : NSObject
/**
 *  文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件的mimeType
 */
@property (nonatomic, copy) NSString *mimeType;


+ (instancetype)fileWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
