//
//  AppDelegate.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/10.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RealReachability.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 网络状态 */
@property (assign , nonatomic) ReachabilityStatus  NetWorkStatus;

@end

