//
//  MTLoadingHUD.m
//  Mita
//
//  Created by CNFOL_iOS on 2017/5/9.
//  Copyright © 2017年 mita. All rights reserved.
//

#import "MTLoadingHUD.h"

static CGFloat lineWidth = 4.0f;

@implementation MTLoadingHUD
{
    CADisplayLink *_link;
    CAShapeLayer *_animationLayer;
    
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
}

+ (MTLoadingHUD *)showIn:(UIView*)view{
    [self hideIn:view];
    MTLoadingHUD *hud = [[MTLoadingHUD alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}

+ (MTLoadingHUD *)hideIn:(UIView *)view{
    MTLoadingHUD *hud = nil;
    for (MTLoadingHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[MTLoadingHUD class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

- (void)start{
    _link.paused = false;
}

- (void)hide{
    _link.paused = true;
    _progress = 0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.bounds = CGRectMake(0, 0, 90, 90);
    backgroundLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
//    backgroundLayer.opacity = 0.95;
    backgroundLayer.cornerRadius = 10;
    [self.layer addSublayer:backgroundLayer];
    
    
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    _animationLayer.strokeColor = [UIColor redColor].CGColor;
    _animationLayer.lineWidth = lineWidth;
    _animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_animationLayer];
    
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
    
}

- (void)displayLinkAction{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

- (void)updateAnimationLayer{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _animationLayer.path = path.CGPath;
}

- (CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}

@end
