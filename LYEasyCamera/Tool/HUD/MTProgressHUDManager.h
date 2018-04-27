//
//  MTProgressHUDManager.h
//  Mita
//
//  Created by CNFOL_iOS on 2017/6/2.
//  Copyright © 2017年 mita. All rights reserved.
//  MBHUD封装管理器

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger,MTProgressMode){
    MTProgressModeOnlyText,           //文字
    MTProgressModeLoading,               //加载菊花
    MTProgressModeCircle,                //加载环形
    MTProgressModeCircleLoading,         //加载圆形-要处理进度值
    MTProgressModeCustomAnimation,       //自定义加载动画（序列帧实现）
    MTProgressModeSuccess,                //成功
    MTProgressModeCustomerImage           //自定义图片
};


@interface MTProgressHUDManager : NSObject

/** HUD属性 */
@property (nonatomic,strong) MBProgressHUD  *hud;

/** 单例 */
+ (instancetype)shareInstance;

/**
 显示MBHUD提示框

 @param msg 显示提示内容
 @param view 所要显示的view
 @param myMode 显示的类型
 @param dimBackground 是否显示蒙版
 */
+ (void)show:(NSString *)msg inView:(UIView *)view mode:(MTProgressMode *)myMode dimBackground:(BOOL)dimBackground;



//-------------------------- 方法调用  --------------------------

/** 显示提示（1秒后消失） */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;
/** 显示提示（N秒后消失） */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay;
/** 在最上层显示 - 不需要指定showview */
+ (void)showMsgWithoutView:(NSString *)msg;
/** 显示成功提示 */
+ (void)showSuccess:(NSString *)msg inview:(UIView *)view;
/** 显示提示、带静态图片，比如失败，用失败图片即可，警告用警告图片等 */
+ (void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view;



/** 显示进度(菊花) */
+ (void)showProgress:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground;
/** 显示进度(环形) */
+ (void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground;
/** 显示进度(转圈-要处理数据加载进度) */
+ (MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground;

/** 显示自定义动画(自定义动画序列帧  找UI做就可以了) */
+ (void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view dimBackground:(BOOL)dimBackground;

/** 隐藏 */
+ (void)hide;

@end


@interface MTProgressHUDView : UIView

@end

