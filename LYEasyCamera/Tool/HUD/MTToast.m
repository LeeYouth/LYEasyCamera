//
//  MTToast.m
//  Mita
//
//  Created by bobo on 17/3/1.
//  Copyright © 2017年 mita. All rights reserved.
//

#import "MTToast.h"
#import "MTLoadingHUD.h"
#import "MTProgressHUDManager.h"

#define TOAST_TIMEOUT 20
#define kDefaultView [UIApplication sharedApplication].delegate.window

@interface MTToast ()

@end

@implementation MTToast

#pragma mark - loading的HUD
+ (void)showLoadingWithStatus:(NSString *)text{
    
    [MTProgressHUDManager hide];
    [MTProgressHUDManager showProgressCircleNoValue:@"" inView:kDefaultView dimBackground:YES];
}

#pragma mark - view中间显示文本提示。
+ (void)centerShowWithText:(NSString *)text delay:(NSTimeInterval)delay{

    [MTProgressHUDManager hide];

    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 0, 50);
    [HUD showInView:kDefaultView];
    [HUD dismissAfterDelay:delay];

}

#pragma mark - view底部显示文本提示。
+ (void)bottomShowWithText:(NSString *)text delay:(NSTimeInterval)delay{
    
    [MTProgressHUDManager hide];
    
    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 60, 50);
    [HUD showInView:kDefaultView];
    [HUD dismissAfterDelay:delay];
}

#pragma mark - hud消失
+ (void)dismiss{
    
    [MTProgressHUDManager hide];
}


#pragma mark - view底部显示文本提示2。
+ (void)bottomShowWithView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    
    [MTProgressHUDManager hide];
    
    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 60, 50);
    [HUD showInView:view];
    [HUD dismissAfterDelay:delay];
    
}

#pragma mark - loading的HUD
+ (void)showLoadingWithView:(UIView *)view{
    [MTProgressHUDManager hide];
    [MTProgressHUDManager showProgressCircleNoValue:@"" inView:view dimBackground:YES];
}

#pragma mark - private methd
#pragma mark 初始化不可点击的JGHUD
+ (JGProgressHUD *)newJGHUD{
    JGProgressHUD *currentHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    currentHUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    return currentHUD;
}



@end
