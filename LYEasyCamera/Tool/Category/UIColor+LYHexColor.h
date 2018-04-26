//
//  UIColor+LYHexColor.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYHexColor)

/**
 *  字符串转换称颜色
 *
 *  @param stringToConvert 需要填充的颜色
 *
 *  @return RGB值
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
