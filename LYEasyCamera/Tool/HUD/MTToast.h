//
//  MTToast.h
//  Mita
//
//  Created by bobo on 17/3/1.
//  Copyright © 2017年 mita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGProgressHUD.h"

@interface MTToast : NSObject


/** loading的HUD */
+ (void)showLoadingWithStatus:(NSString *)text;

/** loading的HUD（需要显示在view上） */
+ (void)showLoadingWithView:(UIView *)view;

/** view中间显示文本提示。 */
+ (void)centerShowWithText:(NSString *)text delay:(NSTimeInterval)delay;

/** view底部显示文本提示。 */
+ (void)bottomShowWithText:(NSString *)text delay:(NSTimeInterval)delay;

/** view底部显示文本提示2。 */
+ (void)bottomShowWithView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay;

/** HUD消失 */
+ (void)dismiss;

@end
