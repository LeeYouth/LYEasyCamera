//
//  LYCustomRefreshHeader.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYCustomRefreshHeader.h"

@interface LYCustomRefreshHeader()

@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UIImageView *arrowImageView;
@property (weak, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation LYCustomRefreshHeader

- (void)prepare {
    
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 40;
    
    // 添加label
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = [UIColor lightGrayColor];
    titleLab.font = LYSystemFont(14.f);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    self.titleLab = titleLab;
    
    // 箭头
    UIImageView *arrowImageView = [UIImageView new];
    arrowImageView.image = [UIImage imageNamed:@"tableview_pull_refresh"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrowImageView];
    self.arrowImageView = arrowImageView;
    
    // loading
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@20);
    }];
    
    CGFloat arrorW = self.mj_h - 10;
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(arrorW, arrorW));
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.right.equalTo(self.titleLab.mas_centerX).offset(-40);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.arrowImageView.mas_centerX);
        make.centerY.equalTo(self.arrowImageView.mas_centerY);
    }];
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        self.titleLab.text = @"下拉刷新";

        if (oldState == MJRefreshStateRefreshing) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.indicatorView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.indicatorView.alpha = 1.0;
                [self.indicatorView stopAnimating];
                self.arrowImageView.hidden = NO;
            }];
        } else {
            [self.indicatorView stopAnimating];
            self.arrowImageView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowImageView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        self.titleLab.text = @"释放更新";
        
        [self.indicatorView stopAnimating];
        self.arrowImageView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.titleLab.text = @"加载中...";
        
        self.indicatorView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.indicatorView startAnimating];
        self.arrowImageView.hidden = YES;
    }
    
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}

@end
