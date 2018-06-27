//
//  LYConfig.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#ifndef LYConfig_h
#define LYConfig_h


// 打印
#ifdef DEBUG
#define LYLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define LYLog(FORMAT, ...) nil;
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MainScreenRect       [UIScreen mainScreen].bounds

#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
#define Height (IS_IPHONEX ? ([[UIScreen mainScreen] bounds].size.height-20):([[UIScreen mainScreen] bounds].size.height))

//全屏的宽高及导航栏高度
#define kNavBarExtra (IS_IPHONEX?24:0)
#define kTabbarExtra (IS_IPHONEX?34:0)

//#define NAVBAR_HEIGHT  64
//#define TABBAR_HEIGHT  49
#define NAVBAR_HEIGHT (64 + kNavBarExtra)
#define TABBAR_HEIGHT (49 + kTabbarExtra)

//cell居左侧间距
#define LYStatusCellMargin 15

//弱引用
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//懒加载
#define LY_LAZY(object, assignment) (object = object ?: assignment)

#define LY_APPDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// 设置字体
#define LYFont(fontName,font)    [UIFont fontWithName:(fontName) size:(font)]
#define LYSystemFont(font)       [UIFont systemFontOfSize:(font)]

// 获取颜色
#define LYColorWithHexStr(str)       [UIColor colorWithHexString:(str)]


// 销毁打印
#define LYDealloc LYLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

// 是否为空对象
#define LYObjectIsNil(__object) ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define LYStringIsEmpty(__string) ((__string.length == 0) || LYObjectIsNil(__string))

// 数组为空
#define LYArrayIsEmpty(__array) ((LYObjectIsNil(__array)) || (__array.count==0))


#endif /* LYConfig_h */
