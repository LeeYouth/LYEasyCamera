//
//  UIViewController+LYHideShadowLine.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "UIViewController+LYHideShadowLine.h"

@implementation UIViewController (LYHideShadowLine)

- (void)LY_hideShadowLineInView:(UIView *)view
{
    UIImageView *navBarLineImageView = [self findLineImageViewUnder:view];
    navBarLineImageView.hidden = YES;
}
- (void)LY_showShadowLineInView:(UIView *)view
{
    UIImageView *navBarLineImageView = [self findLineImageViewUnder:view];
    navBarLineImageView.hidden = NO;
}
- (UIImageView *)findLineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findLineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
