//
//  GPDIYHeader.m
//  GPOnFire
//
//  Created by dandan on 16/3/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDIYHeader.h"

@interface GPDIYHeader()
// 刷新图片
@property (nonatomic, weak) UIImageView *logo;
// 加载菊花
@property (nonatomic, weak) UIActivityIndicatorView *loading;

@end

@implementation GPDIYHeader

#pragma mark - 添加子控件
- (void)prepare
{
    [super prepare];
    
//    // 设置控件的高度
//    self.mj_h = 50;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"login_logo"];
    self.logo = logo;
    [self addSubview:logo];
    // 菊花
    UIActivityIndicatorView *logoing = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loading = logoing;
    [self addSubview:logoing];
}

#pragma mark - 设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.logo.bounds = CGRectMake(0, 0, 100, 50);
    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 40);
    self.loading.center = self.logo.center;
}

#pragma mark - 监听刷新状态的改变
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle: {
            self.loading.hidden = YES;
            self.logo.hidden = NO;
            break;
        }
        case MJRefreshStateRefreshing: {
            self.loading.hidden = NO;
            self.logo.hidden = YES;
            [self.loading startAnimating];
            break;
        }
    }

}


@end
