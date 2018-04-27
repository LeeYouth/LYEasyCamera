//
//  LYNetworkHelper.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYNetworkHelper.h"

/**
 *  是否开启接口打印信息
 */
static BOOL LY_isEnableInterfaceDebug = NO;

@implementation LYFileData

+ (instancetype)fileWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType{
    return [[self alloc] initWithData:data name:name fileName:fileName mimeType:mimeType];
}

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType{
    if(self = [super init]){
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

- (NSString *)fileName{
    if(_fileName == nil){
        _fileName = @"";
    }
    return _fileName;
}

@end

@implementation LYNetworkHelper

static AFHTTPSessionManager *_sessionManager;
static NSMutableArray *_allSessionTask;

#pragma mark - 网络状况的监听
+ (void)networkStatusWithBlock:(NetworkState)networkStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    LYLog(@"未知网络");
                    if (networkStatus) networkStatus(LYNetworkStatusUnknown);
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    LYLog(@"无网络");
                    if (networkStatus) networkStatus(LYNetworkStatusNotReachable);
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    LYLog(@"手机自带网络");
                    if (networkStatus) networkStatus(LYNetworkStatusReachableViaWWAN);
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    LYLog(@"WIFI");
                    if (networkStatus) networkStatus(LYNetworkStatusReachableViaWiFi);
                    break;
            }
        }];
        
        [reachabilityManager startMonitoring];
    });
}

+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork
{
    
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug
{
    LY_isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug
{
    return LY_isEnableInterfaceDebug;
}

+ (void)cancelAllRequest
{
    // 锁操作
    @synchronized(self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL
{
    if (!URL) { return; }
    @synchronized (self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求
+ (NSURLSessionTask *)getWithUrl:(NSString *)Url
                      parameters:(NSDictionary *)parameters
                         showHUD:(BOOL)showHUD
                        progress:(LYUploadProgress)progress
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure
{
    return [self LY_requestWithUrl:Url parameters:parameters showHUD:YES httpMethod:1 progress:progress success:success failure:failure];
}
+ (NSURLSessionTask *)getWithUrl:(NSString *)Url
                      parameters:(NSDictionary *)parameters
                         showHUD:(BOOL)showHUD
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure
{
    return [self LY_requestWithUrl:Url parameters:parameters showHUD:YES httpMethod:1 progress:nil success:success failure:failure];
    
}

#pragma mark - POST请求
+ (NSURLSessionTask *)postWithUrl:(NSString *)Url
                       parameters:(NSDictionary *)parameters
                          showHUD:(BOOL)showHUD
                         progress:(LYUploadProgress)progress
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailed)failure
{
    return [self LY_requestWithUrl:Url parameters:parameters showHUD:YES httpMethod:2 progress:progress success:success failure:failure];
}

+ (NSURLSessionTask *)postWithUrl:(NSString *)Url
                       parameters:(NSDictionary *)parameters
                          showHUD:(BOOL)showHUD
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailed)failure
{
    return [self LY_requestWithUrl:Url parameters:parameters showHUD:YES httpMethod:2 progress:nil success:success failure:failure];
}



#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                              files:(NSArray *)files
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:[self addBaseParmas:parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (LYFileData * filedata in files) {
            [formData appendPartWithFileData:filedata.data
                                        name:filedata.name
                                    fileName:filedata.fileName
                                    mimeType:filedata.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (progress) progress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) success(responseObject);
        
        //打印
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject url:URL params:parameters];
        }
        
        [[self allSessionTask] removeObject:task];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        if (failure) failure(error);
        
        //打印
        if ([self isDebug]) {
            [self logWithFailError:error url:URL params:parameters];
        }
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(HttpRequestFailed)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    return downloadTask;
}


+ (NSURLSessionTask *)LY_requestWithUrl:(NSString *)Url
                             parameters:(NSDictionary *)parameters
                                showHUD:(BOOL)showHUD
                             httpMethod:(NSUInteger)httpMethod
                               progress:(LYUploadProgress)progress
                                success:(HttpRequestSuccess)success
                                failure:(HttpRequestFailed)failure
{
    if (showHUD) {
        [MTToast showLoadingWithStatus:nil];
    }
    
    //get请求
    if (httpMethod == 1)
    {
        NSURLSessionTask *sessionTask = [_sessionManager GET:Url parameters:[self addBaseParmas:parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (showHUD)
            {
                [MTToast dismiss];
            }
            
            if (success) success([self tryToParseData:responseObject]);
            
            //打印
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject url:Url params:parameters];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[self allSessionTask] removeObject:task];
            if (showHUD) {
                
                if (error.code == 3840) {
                    [MTToast bottomShowWithText:@"网络开小差啦" delay:1.5];
                }else{
                    [MTToast bottomShowWithText:error.localizedDescription delay:1.5];
                }
                
            }
            if (failure) failure(error);
            
            //打印
            if ([self isDebug]) {
                [self logWithFailError:error url:Url params:parameters];
            }
            
        }];
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
        
        return sessionTask;
    }else
    {
        if (showHUD) {
            [MTToast showLoadingWithStatus:nil];
        }
        
        NSURLSessionTask *sessionTask = [_sessionManager POST:Url parameters:[self addBaseParmas:parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (showHUD)
            {
                [MTToast dismiss];
            }
            
            if (success) success([self tryToParseData:responseObject]);
            
            //打印
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject url:Url params:parameters];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[self allSessionTask] removeObject:task];
            if (showHUD) {
                
                if (error.code == 3840) {
                    [MTToast bottomShowWithText:@"网络开小差啦" delay:1.5];
                }else{
                    [MTToast bottomShowWithText:error.localizedDescription delay:1.5];
                }
                
            }
            if (failure) failure(error);
            
            //打印
            if ([self isDebug]) {
                [self logWithFailError:error url:Url params:parameters];
            }
            
        }];
        // 添加sessionTask到数组
        sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
        
        return sessionTask;
    }
    
    
}


#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setRequestSerializer:(LYRequestSerializer)requestSerializer
{
    _sessionManager.requestSerializer = requestSerializer==LYRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(LYResponseSerializer)responseSerializer
{
    _sessionManager.responseSerializer = responseSerializer==LYResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time
{
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}





/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask
{
    if (!_allSessionTask)
    {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager,原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 *  + (void)initialize该初始化方法在当用到此类时候只调用一次
 */
+ (void)initialize
{
    
    /**
     要使用常规的AFN网络访问
     
     1. AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     
     所有的网络请求,均有manager发起
     
     2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
     
     1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
     2> 如果返回格式不是JSON的,
     
     3. 请求格式
     
     AFHTTPRequestSerializer            二进制格式
     AFJSONRequestSerializer            JSON
     AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
     
     4. 返回格式
     
     AFHTTPResponseSerializer           二进制格式
     AFJSONResponseSerializer           JSON
     AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
     AFXMLDocumentResponseSerializer (Mac OS X)
     AFPropertyListResponseSerializer   PList
     AFImageResponseSerializer          Image
     AFCompoundResponseSerializer       组合
     */
    
    NSString *baseUrl = [LYServerConfig getLYServerAddress];
    _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    //    [self loadCertificate:_sessionManager];
    
    // 设置请求参数的类型:JSON (AFJSONRequestSerializer:JSON,AFHTTPRequestSerializer:二进制格式)
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}


#pragma mark - Private

+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    LYLog(@"\n");
    LYLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    LYLog(@"\n");
    if ([error code] == NSURLErrorCancelled) {
        LYLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params);
    } else {
        LYLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params,
              [error localizedDescription]);
    }
}

+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(NSDictionary *)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}
// 解析json数据
+ (id)tryToParseData:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

#pragma mark - 添加基础参数
+ (NSMutableDictionary *)addBaseParmas:(NSDictionary *)parameters
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (parameters != nil)
    {
        [params setDictionary:parameters];
    }
    
//    NSString *fromType     = @"iOS";
//    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSString *localVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    NSString *buildVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    NSString *networkType  = [MTAppTools networkingStatesFromStatebar];
//

    return params;
}
@end
