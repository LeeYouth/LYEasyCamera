//
//  LYReactiveView.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//  绑定viewmodel的代理

#import <Foundation/Foundation.h>

@protocol LYReactiveView <NSObject>

/**
 绑定一个viewmodel给view
 
 @param viewModel Viewmodel
 */
- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params;

@end
