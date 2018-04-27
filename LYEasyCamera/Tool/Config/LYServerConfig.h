//
//  LYServerConfig.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /** 测试环境 */
    LYServerEnvDevelop,
    /** 正式环境 */
    LYServerEnvProduce,
} LYServerEnvType;

@interface LYServerConfig : NSObject

// env: 环境参数 00: 测试环境 01: 正式环境
+ (void)setLYConfigEnv:(LYServerEnvType)value;

// 返回环境参数 00: 测试环境 01: 正式环境
+ (LYServerEnvType)LYConfigEnv;

// 获取服务器地址
+ (NSString *)getLYServerAddress;

@end
