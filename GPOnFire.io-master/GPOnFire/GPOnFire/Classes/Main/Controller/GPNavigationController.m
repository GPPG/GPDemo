//
//  GPNavigationController.m
//  GPOnFire
//
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNavigationController.h"

@interface GPNavigationController ()

@end

@implementation GPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

// 重写push方法,方便统一处理返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

@end
