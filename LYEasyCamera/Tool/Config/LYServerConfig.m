//
//  LYServerConfig.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYServerConfig.h"
static NSString *LYConfigEnv;  //环境参数 00: 测试环境,01: 正式环境

@implementation LYServerConfig

// env: 环境参数 00: 测试环境 01: 生产环境
+ (void)setLYConfigEnv:(LYServerEnvType)value
{
    if (value == LYServerEnvDevelop) {
        LYConfigEnv = @"00";
    }else if(value == LYServerEnvProduce){
        LYConfigEnv = @"01";
    }
}

// 返回环境参数 00: 测试环境 01: 生产环境
+ (LYServerEnvType)LYConfigEnv
{
    if ([LYConfigEnv isEqualToString:@"00"]) {
        return LYServerEnvDevelop;
    }
    return LYServerEnvProduce;
}

// 获取服务器地址
+ (NSString *)getLYServerAddress
{
    if ([LYConfigEnv isEqualToString:@"00"]) {
        return LYURL_TEST_BASE_SERVER;
    }else{
        return LYURL_BASE_SERVER;
    }
}

@end
