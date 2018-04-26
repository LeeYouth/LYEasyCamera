//
//  LYBaseViewController.h
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/25.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYViewModel;

@interface LYBaseViewController : UIViewController

/** viewModel */
@property (strong, nonatomic, readonly) LYViewModel *viewModel;
/** NavBar */
@property (strong, nonatomic) UINavigationBar *navBar;

- (instancetype)initWithViewModel:(LYViewModel *)viewModel;
- (void)bindViewModel;
+ (void)popCallBack:(NSDictionary *)infoDic;

@end
