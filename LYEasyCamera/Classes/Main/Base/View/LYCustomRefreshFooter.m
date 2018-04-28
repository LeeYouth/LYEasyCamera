//
//  LYCustomRefreshFooter.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/28.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYCustomRefreshFooter.h"

@interface LYCustomRefreshFooter()

@property (weak, nonatomic) UILabel *label;

@end

@implementation LYCustomRefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 40;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = LYColorWithHexStr(@"#999999");
    label.font = LYSystemFont(14.f);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
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
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载更多";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"释放加载数据";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载中...";
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"没有更多了";
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}

@end
