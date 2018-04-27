//
//  MTLoadingHUD.h
//  Mita
//
//  Created by CNFOL_iOS on 2017/5/9.
//  Copyright © 2017年 mita. All rights reserved.
//  加载中视图

#import <UIKit/UIKit.h>

@interface MTLoadingHUD : UIView<CAAnimationDelegate>

- (void)start;

- (void)hide;

+ (MTLoadingHUD *)showIn:(UIView*)view;

+ (MTLoadingHUD *)hideIn:(UIView*)view;

@end
