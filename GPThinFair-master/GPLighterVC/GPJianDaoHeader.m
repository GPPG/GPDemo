//
//  GPJianDaoHeader.m
//  GPHandMade
//
//  Created by dandan on 16/5/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPJianDaoHeader.h"

@implementation GPJianDaoHeader

- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"小客正在为你刷新" forState:MJRefreshStateRefreshing];
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    self.stateLabel.textColor = [UIColor  darkGrayColor];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:idleImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}
@end
