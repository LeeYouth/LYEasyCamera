//
//  MTProgressHUDManager.m
//  Mita
//
//  Created by CNFOL_iOS on 2017/6/2.
//  Copyright © 2017年 mita. All rights reserved.
//

#import "MTProgressHUDManager.h"
#import "MTLoadingHUD.h"

@implementation MTProgressHUDManager

+ (instancetype)shareInstance{
    
    static MTProgressHUDManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MTProgressHUDManager alloc] init];
    });
    
    return instance;
    
}

+ (void)show:(NSString *)msg inView:(UIView *)view mode:(MTProgressMode *)myMode  dimBackground:(BOOL)dimBackground{
    [self show:msg inView:view mode:myMode customImgView:nil dimBackground:dimBackground];
}

+ (void)show:(NSString *)msg inView:(UIView *)view mode:(MTProgressMode *)myMode customImgView:(UIImageView *)customImgView dimBackground:(BOOL)dimBackground{
    //如果已有弹框，先消失
    if ([MTProgressHUDManager shareInstance].hud != nil) {
        [[MTProgressHUDManager shareInstance].hud hideAnimated:YES];
        [MTProgressHUDManager shareInstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [MTProgressHUDManager shareInstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    if (dimBackground) {
        //这里设置是否显示遮罩层
        [MTProgressHUDManager shareInstance].hud.dimBackground = YES;    //是否显示透明背景
    }
    
    //是否设置黑色背景，这两句配合使用
    [MTProgressHUDManager shareInstance].hud.bezelView.color = [UIColor whiteColor];
    [MTProgressHUDManager shareInstance].hud.contentColor = [UIColor blackColor];
    
    [[MTProgressHUDManager shareInstance].hud setMargin:10];
    [[MTProgressHUDManager shareInstance].hud setRemoveFromSuperViewOnHide:YES];
    [MTProgressHUDManager shareInstance].hud.detailsLabel.text = msg;
    
    [MTProgressHUDManager shareInstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case MTProgressModeOnlyText:
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case MTProgressModeLoading:
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case MTProgressModeCircle:{
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeCustomView;
            
            CGFloat hudW = 120;
            
            [MTProgressHUDManager shareInstance].hud.minSize = CGSizeMake(hudW, hudW);

            MTProgressHUDView *loading =  [[MTProgressHUDView alloc] initWithFrame:CGRectMake(0, 0, hudW, hudW)];
            [MTProgressHUDManager shareInstance].hud.customView = loading;
            
            
            break;
        }
        case MTProgressModeCustomerImage:
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeCustomView;
            [MTProgressHUDManager shareInstance].hud.customView = customImgView;
            break;
            
        case MTProgressModeCustomAnimation:
            //这里设置动画的背景色
            [MTProgressHUDManager shareInstance].hud.bezelView.color = [UIColor yellowColor];
            
            
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeCustomView;
            [MTProgressHUDManager shareInstance].hud.customView = customImgView;
            
            break;
            
        case MTProgressModeSuccess:
            [MTProgressHUDManager shareInstance].hud.mode = MBProgressHUDModeCustomView;
            [MTProgressHUDManager shareInstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
}


#pragma mark - 不带灰色蒙版
+ (void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:MTProgressModeOnlyText dimBackground:NO];
    [[MTProgressHUDManager shareInstance].hud hideAnimated:YES afterDelay:1.0];
}
+ (void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:MTProgressModeOnlyText dimBackground:NO];
    [[MTProgressHUDManager shareInstance].hud hideAnimated:YES afterDelay:delay];
}
+ (void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:MTProgressModeOnlyText dimBackground:NO];
    [[MTProgressHUDManager shareInstance].hud hideAnimated:YES afterDelay:1.0];
}
+ (void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:MTProgressModeSuccess dimBackground:NO];
    [[MTProgressHUDManager shareInstance].hud hideAnimated:YES afterDelay:1.0];
    
}
+ (void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view mode:MTProgressModeCustomerImage customImgView:img dimBackground:NO];
    [[MTProgressHUDManager shareInstance].hud hideAnimated:YES afterDelay:1.0];
}


#pragma mark - 选择是否带灰色蒙版
+ (void)showProgress:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground{
    [self show:msg inView:view mode:MTProgressModeLoading dimBackground:dimBackground];
}
+ (void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground{
    [self show:msg inView:view mode:MTProgressModeCircle dimBackground:dimBackground];
}
+ (MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view dimBackground:(BOOL)dimBackground{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = msg;
    if (dimBackground) {
        //这里设置是否显示遮罩层
        hud.dimBackground = YES;    //是否显示透明背景
    }
    return hud;
    
    
}
+ (void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view dimBackground:(BOOL)dimBackground{
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:MTProgressModeCustomAnimation customImgView:showImageView dimBackground:dimBackground];
}



#pragma mark - 隐藏
+ (void)hide{
    if ([MTProgressHUDManager shareInstance].hud != nil) {
        [[MTProgressHUDManager shareInstance].hud hideAnimated:YES];
    }
}



@end



#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation MTProgressHUDView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews{
    
    CGFloat lineWidth = 4.f;

    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.lineWidth = lineWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 50, 50);
    layer.lineCap = kCALineCapRound;
    
    
    CGFloat radius = layer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = layer.bounds.size.width/2.0f;
    CGFloat centerY = layer.bounds.size.height/2.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    //画一个圆
    CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.5;
    strokeEndAnimation.values = @[@0.0, @1];
    strokeEndAnimation.keyTimes = @[@0.0,@1];
    
    //旋转2圈
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAni.fromValue = @(DEGREES_TO_RADIANS(0));
    rotaAni.toValue = @(DEGREES_TO_RADIANS(720));
    rotaAni.autoreverses = YES;
    
    //最后填充颜色
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置颜色
    animation.toValue=(id)[UIColor blackColor].CGColor; //必须要用黑色
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = INFINITY;
    group.duration = 2;
    group.animations = @[strokeEndAnimation,rotaAni,animation];
    
    [layer addAnimation:group forKey:nil];

}

@end
