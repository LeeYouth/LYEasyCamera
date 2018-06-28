//
//  LYMediatorAction.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/6/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "VKMsgSend.h"

typedef void (^LYPopViewControllerCompletion)(__kindof UIViewController *popViewController);

@interface LYMediatorAction : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程调用入口(服务器下发)
 */
- (void)performActionWithUrl:(NSString *)url animated:(BOOL)animated;
/**
 *  本地组件调用入口
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName;

@end
